require 'minitest/autorun'
require 'active_support'
require 'minitest-spec-rails'
require 'minitest-spec-rails/init/active_support'
require 'minitest-spec-rails/init/mini_shoulda'

require File.dirname(__FILE__) + '/../lib/simplepay'

module Simplepay #:nodoc:
  module Macros #:nodoc: all
    
    def should_not_have_service_field(*names)
      klass = model_class
      
      names.each do |name|
        should "not have a field named #{name.inspect}" do
          assert !klass.fields.any? { |f| f.name == name }
        end
      end
    end
    
    def should_have_service_field(*names)
      delegate_class, service_name, required = get_options!(names, :class, :as, :required)
      klass = model_class
      
      names.each do |name|
        should "have a field named #{name.inspect}" do
          message = "#{klass} does not have a Field named #{name.inspect}"
          assert klass.fields.any? { |f| f.name == name }, message
        end
        
        context "#{name} field" do
          should("delegate to #{delegate_class}") do
            message = "#{klass} field #{name.inspect} failed to delegate to #{delegate_class}"
            field   = klass.fields.detect { |f| f.name == name }
            assert_equal delegate_class, field.delegate, message
          end if delegate_class
          
          should("not delegate") do
            field   = klass.fields.detect { |f| f.name == name }
            message = "#{klass} field #{name.inspect} unexpectedly delegated to #{field.delegate}"
            assert !field.delegated?, message
          end unless delegate_class
          
          should("have a #{service_name} service name") do
            message = "#{klass} field #{name.inspect} failed to have expected service name"
            field   = klass.fields.detect { |f| f.name == name }
            assert_equal service_name, field.service_name
          end if service_name
          
          should("#{"not " unless required}be required") do
            message = "#{klass} field #{name.inspect} was#{" not" if required} required"
            field   = klass.fields.detect { |f| f.name == name }
            assert_equal required, field.required?, message
          end
        end
      end
    end unless method_defined?(:should_have_service_field)
    
    protected
    
    # Returns the values for the entries in the args hash who's keys are listed in the wanted array.
    # Will raise if there are keys in the args hash that aren't listed.
    def get_options!(args, *wanted)
      ret  = []
      opts = (args.last.is_a?(Hash) ? args.pop : {})
      wanted.each {|w| ret << opts.delete(w)}
      raise ArgumentError, "Unsupported options given: #{opts.keys.join(', ')}" unless opts.keys.empty?
      return *ret
    end unless method_defined?(:get_options!)
    
  end
end

ActiveSupport::TestCase.send :extend, Simplepay::Macros
