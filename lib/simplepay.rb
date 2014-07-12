require 'rails'
require 'active_support/dependencies'

module Simplepay
  autoload :Constants, 'simplepay/constants'
  autoload :Support, 'simplepay/support'
  autoload :Authentication, 'simplepay/authentication'
  autoload :Service, 'simplepay/service'
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

p 'engined'
require "simplepay/engine" if defined?(::Rails)
