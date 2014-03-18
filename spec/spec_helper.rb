#
# Copyright 2014 Arthur Shagall
#
unless ENV['TRAVIS']
  require 'simplecov'
  SimpleCov.start
end

require 'bundler/setup'

require 'enum_aasm'

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
end
