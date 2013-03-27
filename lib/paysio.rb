require 'active_support/deprecation'
require 'active_support/core_ext/module'
require 'active_support/core_ext/hash'
require 'active_support/inflector'
require 'rest-client'
require 'oj'

# utils
require 'paysio/client'
require 'paysio/json'
require 'paysio/resource'
require 'paysio/version'

# actions
require 'paysio/actions/list'
require 'paysio/actions/create'
require 'paysio/actions/update'
require 'paysio/actions/destroy'
require 'paysio/actions/find'

# exceptions
require 'paysio/exceptions'

# resources
require 'paysio/resources/list'
require 'paysio/resources/charge'
require 'paysio/resources/wallet'
require 'paysio/resources/customer'
require 'paysio/resources/reward'
require 'paysio/resources/coupon'
require 'paysio/resources/event'
require 'paysio/resources/payout'
require 'paysio/resources/log'

module Paysio
  @@api_key = nil
  @@api_base = 'api.paysio.com'
  @@api_version = 'v1'
  mattr_accessor :api_key, :api_base, :api_version

  def self.api_url(path = '')
    "https://#{api_key}@#{api_base}/#{api_version}#{path}"
  end
end
