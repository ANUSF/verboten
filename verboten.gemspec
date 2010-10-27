# Copyright (c) 2010 ANU

Gem::Specification.new do |s|
  s.name     = 'verboten'
  s.version  = '0.1.0'
  s.platform = Gem::Platform::RUBY
  s.authors  = ['Olaf Delgado-Friedrichs', 'ANUSF']
  s.email    = ['olaf.delgado-friedrichs@anu.edu.au']
  s.homepage = 'http://sf.anu.edu.au/~oxd900'
  s.required_rubygems_version = '>= 1.3.5'
  s.add_development_dependency 'rspec'
  s.files    = Dir.glob('{lib,spec}/**/*') + %w{MIT-LICENSE README.rdoc}
  s.require_path = 'lib'

  s.summary = 'Simple white-list authorization for Rails.'
  s.description = %q{
  Verboten is a lightweight authorization gem for Rails working on the
  principle that everything is forbidden unless it is explicitly
  permitted.

  Simply including the module 'Verboten' into your controllers
  disables all actions by default and defines two new methods,
  'permit' and 'before_authorization_filter'. The former is used to
  permit actions selectively. The latter makes sure certain before
  filters run before authorization is tested, so that they can set the
  required instance variables (see examples in the README).
  }
end
