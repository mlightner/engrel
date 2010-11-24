# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{engrel}
  s.version = "0.9.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matt Lightner"]
  s.date = %q{2010-11-24}
  s.description = %q{Allows for natural grammar to specify object relationships based on parts of speech.}
  s.email = %q{mlightner@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    "README.rdoc",
    "lib/engrel.rb",
    "lib/engrel/mixin.rb",
    "lib/engrel/prepositional_phrase.rb",
    "lib/engrel/sentence.rb",
    "lib/generators/engrel_generator.rb",
    "lib/generators/templates/create_engrel_tables.rb"
  ]
  s.homepage = %q{http://engrel.com}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{A highly flexible entity relationship management system that requires only two tables and lots of clever.}
  s.test_files = [
    "test/helper.rb",
    "test/test_engrel.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, [">= 3.0.0"])
      s.add_runtime_dependency(%q<activesupport>, [">= 3.0.0"])
      s.add_runtime_dependency(%q<text-highlight>, [">= 0"])
      s.add_runtime_dependency(%q<enumerated_attribute>, [">= 0"])
      s.add_development_dependency(%q<yard>, ["~> 0.6.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.1"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_runtime_dependency(%q<enumerable_attributes>, ["> 0.1"])
      s.add_runtime_dependency(%q<active_support>, ["> 3.0.0"])
    else
      s.add_dependency(%q<activerecord>, [">= 3.0.0"])
      s.add_dependency(%q<activesupport>, [">= 3.0.0"])
      s.add_dependency(%q<text-highlight>, [">= 0"])
      s.add_dependency(%q<enumerated_attribute>, [">= 0"])
      s.add_dependency(%q<yard>, ["~> 0.6.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.1"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<enumerable_attributes>, ["> 0.1"])
      s.add_dependency(%q<active_support>, ["> 3.0.0"])
    end
  else
    s.add_dependency(%q<activerecord>, [">= 3.0.0"])
    s.add_dependency(%q<activesupport>, [">= 3.0.0"])
    s.add_dependency(%q<text-highlight>, [">= 0"])
    s.add_dependency(%q<enumerated_attribute>, [">= 0"])
    s.add_dependency(%q<yard>, ["~> 0.6.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.1"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<enumerable_attributes>, ["> 0.1"])
    s.add_dependency(%q<active_support>, ["> 3.0.0"])
  end
end

