$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)
require 'simplecov'
SimpleCov.start
require 'rspec'
require 'rack/test'
require 'webmock/rspec'
require 'vcr'
require 'omniauth/core'
require 'omniauth/test'
require 'omniauth/oauth'
require File.expand_path('../support/shared_examples', __FILE__)

RSpec.configure do |config|
  config.include WebMock::API
  config.extend VCR::RSpec::Macros
  config.include Rack::Test::Methods
  config.extend  OmniAuth::Test::StrategyMacros, :type => :strategy
end

def strategy_class
  meta = self.class.metadata
  while meta.key?(:example_group)
    meta = meta[:example_group]
  end
  meta[:describes]
end

def app
  lambda{|env| [200, {}, ['Hello']]}
end
