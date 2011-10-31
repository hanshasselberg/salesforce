# encoding: utf-8
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require "salesforce/version"

Gem::Specification.new do |s|
  s.name        = "salesforce"
  s.version     = Salesforce::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Martin Jagusch", "Hans Hasselberg"]
  s.summary     = "Elegant Salesforce REST API integration."
  s.description = "todo"

  s.required_rubygems_version = ">= 1.3.6"

  s.add_dependency("typhoeus")
  s.add_dependency("json")
  s.add_dependency("active_support")

  s.add_development_dependency("rdoc", ["~> 3.5.0"])
  s.add_development_dependency("rspec", ["~> 2.6"])
  s.add_development_dependency("watchr", ["~> 0.6"])

  s.files        = Dir.glob("lib/**/*") + %w(LICENSE README.md Rakefile)
  s.require_path = 'lib'
end

