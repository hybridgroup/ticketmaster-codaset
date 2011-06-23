# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ticketmaster-codaset}
  s.version = "0.1.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["HybridGroup"]
  s.date = %q{2011-06-23}
  s.description = %q{Allows ticketmaster to interact with Codaset.}
  s.email = %q{ana@hybridgroup.com}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rspec",
    ".rvmrc",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.md",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "changelog.txt",
    "lib/codaset/.gitignore",
    "lib/codaset/codaset-api.rb",
    "lib/provider/codaset.rb",
    "lib/provider/comment.rb",
    "lib/provider/project.rb",
    "lib/provider/ticket.rb",
    "lib/ticketmaster-codaset.rb",
    "spec/comments_spec.rb",
    "spec/fixtures/my-project.json",
    "spec/fixtures/new-project.json",
    "spec/fixtures/new-ticket.json",
    "spec/fixtures/projects.json",
    "spec/fixtures/tickets.json",
    "spec/fixtures/tickets/1.json",
    "spec/projects_spec.rb",
    "spec/spec.opts",
    "spec/spec_helper.rb",
    "spec/ticketmaster-codaset_spec.rb",
    "spec/tickets_spec.rb",
    "ticketmaster-codaset.gemspec"
  ]
  s.homepage = %q{http://ticketrb.com}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{This is a ticketmaster provider for interacting with Codaset}
  s.test_files = [
    "spec/comments_spec.rb",
    "spec/projects_spec.rb",
    "spec/spec_helper.rb",
    "spec/ticketmaster-codaset_spec.rb",
    "spec/tickets_spec.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ticketmaster>, ["= 0.5.2"])
      s.add_runtime_dependency(%q<oauth2>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.1"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_runtime_dependency(%q<activesupport>, [">= 2.3.0"])
      s.add_runtime_dependency(%q<activeresource>, [">= 2.3.0"])
    else
      s.add_dependency(%q<ticketmaster>, ["= 0.5.2"])
      s.add_dependency(%q<oauth2>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.1"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<activesupport>, [">= 2.3.0"])
      s.add_dependency(%q<activeresource>, [">= 2.3.0"])
    end
  else
    s.add_dependency(%q<ticketmaster>, ["= 0.5.2"])
    s.add_dependency(%q<oauth2>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.1"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<activesupport>, [">= 2.3.0"])
    s.add_dependency(%q<activeresource>, [">= 2.3.0"])
  end
end

