module Simplepay
  module Rails
    
    ##
    # Adds helpers to your views for generating the correct HTML forms and 
    # valid signatures.
    # 
    module SimplepayHelper
      
      ##
      # This is the general interface for generating your Simple Pay service
      # forms.  See Simplepay::Services for available services and information
      # specific to each.
      # 
      # === Example
      # 
      #     (in your view)
      # 
      #     <%= simplepay_form_for(:service_name, {:attr => 'foo'}) %>
      # 
      def simplepay_form_for(service_name, attributes = {}, submit_tag = nil)
        service = get_simplepay_service(service_name)
        if block_given?
          submit_tag = capture(&Proc.new)
        end
        service.form(attributes, submit_tag).html_safe
      end
      
      
      private
      
      
      def get_simplepay_service(name) #:nodoc:
        service = "Simplepay::Services::#{name.to_s.camelize}".constantize
        service.new
      end
      
    end
    
  end
end
