require 'paysio'
require 'support/paysio'
require 'support/paysio_responses'
require 'support/test_matchers'
RSpec.configure do |config|
  include Paysio::TestResponses
  config.mock_with :mocha
end