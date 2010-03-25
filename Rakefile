require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "verboten"
    gem.summary = %Q{Simple white-list authorization for Rails.}
    gem.description = %Q{
Verboten is a lightweight authorization plugin for Rails working on
the principle that everything is forbidden unless it is explicitly
permitted.

To enable the plugin for a given controller, include the command
'forbid_everything'. This defines two instance methods, 'permit' and
'before_authorization_filter'. The former is used to permit actions
selectively. The latter makes sure certain before filters run before
authorization is tested, so that they can set the required instance
variables (see examples in the README).
}
    gem.email = "olaf.delgado-friedrichs@anu.edu.au"
    gem.homepage = "http://sf.anu.edu.au/~oxd900"
    gem.authors = ["Olaf Delgado-Friedrichs", "ANUSF"]
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.files = FileList['lib/**/*.rb']
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "verboten #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
