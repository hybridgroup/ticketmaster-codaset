require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "ticketmaster-codaset"
  gem.homepage = "http://github.com/hybridgroup/ticketmaster-codaset"
  gem.license = "MIT"
  gem.summary = %Q{The codaset provider for ticketmaster}
  gem.description = %Q{TODO: longer description of your gem}
  gem.email = "ana@hybridgroup.com"
  gem.authors = ["anymoto"]
  gem.add_development_dependency "rspec", ">= 1.2.9"
  gem.add_dependency "ticketmaster", ">= 0.3.0"
  gem.add_dependency "activesupport", ">= 2.3.0"
  gem.add_dependency "activeresource", ">= 2.3.0"
end
Jeweler::RubygemsDotOrgTasks.new

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
end
