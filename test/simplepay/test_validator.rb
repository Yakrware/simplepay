require File.dirname(__FILE__) + '/../../test_helper'
require "simplepay/validator"

class TestValidatorClass
  include Simplepay::Validator
  
  def testing(request_hash = {})
    valid_simplepay_request?(request_hash)
  end
end

class Simplepay::TestValidatorHelper < Test::Unit::TestCase
  
  context 'Simplepay::Validator' do
    
    setup do
      @validator = TestValidatorClass.new
    end
    
    should 'defer to Simplepay::Authentication.authentic?' do
      #Simplepay::Authentication.expects(:authentic?).with({:test => 'testing'}, 'signed').returns(true)
      #assert @validator.testing({:test => 'testing', :signature => 'signed'})
    end
    
    should 'work with string hash keys' do
      #Simplepay::Authentication.expects(:authentic?).with({:test => 'testing'}, 'signed').returns(true)
      #assert @validator.testing({"test" => 'testing', "signature" => 'signed'})
    end
    
  end
  
end
