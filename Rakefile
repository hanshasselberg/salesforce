require "bundler"
Bundler.setup

require "rake"
require "rdoc/task"
require "rspec"
require "rspec/core/rake_task"

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "salesforce/version"

task :gem => :build
task :build do
  system "gem build salesforce.gemspec"
end

task :release => :build do
  system "git tag -a v#{Salesforce::VERSION} -m 'Tagging #{Salesforce::VERSION}'"
  system "git push --tags"
  system "gem push salesforce-#{Salesforce::VERSION}.gem"
end

RSpec::Core::RakeTask.new("spec:unit") do |spec|
  spec.pattern = "spec/unit/**/*_spec.rb"
end

RSpec::Core::RakeTask.new("spec:functional") do |spec|
  spec.pattern = "spec/functional/**/*_spec.rb"
end

RSpec::Core::RakeTask.new('spec:progress') do |spec|
  spec.rspec_opts = %w(--format progress)
  spec.pattern = "spec/**/*_spec.rb"
end

task :spec => [ "spec:functional", "spec:unit" ]
task :default => :spec
