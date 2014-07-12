require 'rails'
require 'active_support/dependencies'

module Simplepay
  autoload :Constants, 'simplepay/constants'
  autoload :Service, 'simplepay/service'
  module Services  
    autoload :Donation, 'simplepay/services/donation'
    autoload :Marketplace, 'simplepay/services/marketplace'
    autoload :Marketplace_policy, 'simplepay/services/marketplace_policy'
    autoload :Standard, 'simplepay/services/standard'
    autoload :Subscription, 'simplepay/services/subscription'
  end
  autoload :Signature, 'simplepay/signature'
  autoload :Support, 'simplepay/support'
  autoload :Validator, 'simplepay/validator'  
    
  mattr_accessor :aws_access_key_id
  @@aws_access_key_id = '' 
  mattr_accessor :aws_secret_access_key
  @@aws_secret_access_key = ''  
  mattr_accessor :use_sandbox
  @@use_sandbox = true

  def self.use_sandbox?
    @@use_sandbox
  end

  def self.setup
    yield self
  end
  
  ActiveSupport.on_load(:action_controller) do
    include ::Simplepay::Validator
  end
end

require "simplepay/engine" if defined?(::Rails)
