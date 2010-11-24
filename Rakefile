require 'rubygems'
require 'bundler'
$: << File.dirname(__FILE__) + '/lib/engrel/'

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
  gem.name = "engrel"
  gem.homepage = "http://engrel.com"
  gem.license = "MIT"
  gem.summary = %Q{A highly flexible entity relationship management system that requires only two tables and lots of clever.}
  gem.description = %Q{TODO: longer description of your gem}
  gem.email = "mlightner@gmail.com"
  gem.authors = ["Matt Lightner"]
  # Include your dependencies below. Runtime dependencies are required when using your gem,
  # and development dependencies are only needed for development (ie running rake tasks, tests, etc)
  gem.require_path = 'lib'
  gem.files = %w(MIT-LICENSE README.rdoc) + Dir.glob("{generators,lib,tasks}/**/*")
  gem.add_runtime_dependency 'enumerable_attributes', '> 0.1'
  gem.add_runtime_dependency 'active_support', '> 3.0.0'
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

require 'rcov/rcovtask'
Rcov::RcovTask.new do |test|
  test.libs << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

task :default => :test

require 'yard'
YARD::Rake::YardocTask.new
