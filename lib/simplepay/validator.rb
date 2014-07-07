require 'cgi'
require 'nokogiri'
require 'open-uri'

module Simplepay    
  module Validator
    extend ActiveSupport::Concern
    
    protected
    
    ##
    # Authenticates the incoming request by validating the +signature+ 
    # provided.
    # 
    #     (from within your controller)
    #     def receive_ipn
    #       if valid_simplepay_request?(params)
    #         ...
    #       end
    #     end
    # 
    def valid_simplepay_request?(params, endpoint = request.url[/\A[^?]+/])
      host    = Simplepay.use_sandbox ? "https://fps.sandbox.amazonaws.com" :
                                        "https://fps.amazonaws.com"
      query   = build_simplepay_query_string( params.except( :controller,
                                                             :action,
                                                             :id ) )
      request = { "Action"         => "VerifySignature",
                  "Version"        => "2008-09-17",
                  "UrlEndPoint"    => endpoint,
                  "HttpParameters" => query }
      url     = "#{host}/?#{build_simplepay_query_string(request)}"
      
      uri               = URI.parse(url)
      http              = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl      = true
      http.ca_file      = File.join(File.dirname(__FILE__), "ca-bundle.crt")
      http.verify_mode  = OpenSSL::SSL::VERIFY_PEER
      http.verify_depth = 5

      response = http.start { |session|
        get = Net::HTTP::Get.new("#{uri.path}?#{uri.query}")
        session.request(get)
      }

      xml = Nokogiri.XML(response.body)
      xml && xml.xpath( "//xmlns:VerificationStatus/text()",
                        xml.namespaces ).to_s == "Success"
    rescue
      false
    end
    
    def build_simplepay_query_string(params)
      params.map { |k, v|
        "#{CGI.escape(k.to_s)}=#{CGI.escape(v.to_s)}"
      }.join("&")
    end
  end
end
