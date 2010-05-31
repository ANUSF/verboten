module Verboten
  module ClassMethods
    def permit(*args, &code)
      options = args.last.is_a?(Hash) ? args.pop : {}
      if block_given?
        options[:if] = code
      else
        case options[:if]
        when :logged_in  then options[:message] ||= "Must be logged in."
        when :logged_out then options[:message] ||= "Must be logged out."
        end
      end
      args.each { |name| self.permission_settings[name.to_sym] = options }
    end

    def before_authorization_filter(*args)
      before_filter *args
      skip_before_filter :authorize
      before_filter :authorize
    end
  end

  module InstanceMethods
    def logged_in
      not logged_out
    end

    def logged_out
      current_user.nil?
    end

    def authorize
      begin
        if self.respond_to? :permitted
          allowed = self.send :permitted, action_name, params
          options = {}
        else
          options = self.class.permission_settings[action_name.to_sym] ||
            { :if => false }
          allowed = case options[:if]
                    when nil    then true
                    when Proc   then self.instance_eval(&options[:if])
                    when Symbol then self.send(options[:if])
                    else             options[:if]
                    end
        end
      rescue => ex
        flash_error "Error in authorization test: #{ex}"
      else
        if allowed.is_a? String
          message = allowed
          allowed = false
        else
          message = options[:message] || "Access denied."
        end
        flash_error(message) unless allowed
      end
    end

    protected
    def flash_error(message)
      flash.now[:error] = message
      render :text => '', :layout => true
    end
  end
end

class ActionController::Base
  def self.forbid_everything
    class_inheritable_accessor :permission_settings
    self.permission_settings = {}

    extend Verboten::ClassMethods
    include Verboten::InstanceMethods

    before_filter :authorize
  end
end
