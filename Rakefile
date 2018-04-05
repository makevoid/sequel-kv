# # TODO: choose one
#
# desc "Test (Rspec)"
# task :test do
#   sh "bundle exec rspec"
# end
#
# task default: :test

# ---

require 'bundler'
Bundler.require :default, :test

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new :spec
task default: :spec
