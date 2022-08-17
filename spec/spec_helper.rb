# frozen_string_literal: true

require 'bundler/setup'
require 'petfinder'
require 'webmock/rspec'
require 'simplecov'

SimpleCov.start do
  coverage_dir(File.join('..', '..', '..', ENV['CIRCLE_ARTIFACTS'], 'coverage')) if ENV['CIRCLE_ARTIFACTS']
  minimum_coverage(100)
  add_filter('/spec/')
  # add_group('Lib', 'lib')
  # track_files("**/*.rb")
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
