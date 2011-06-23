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
  gem.homepage = "http://ticketrb.com"
  gem.summary = %Q{This is a ticketmaster provider for interacting with Codaset}
  gem.description = %Q{Allows ticketmaster to interact with Codaset.}
  gem.email = "ana@hybridgroup.com"
  gem.authors = ["HybridGroup"]
  gem.add_dependency "activesupport", ">= 2.3.0"
  gem.add_dependency "activeresource", ">= 2.3.0"
end
Jeweler::RubygemsDotOrgTasks.new

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
end
