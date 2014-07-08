module Simplepay
  module Helpers
    
    module FormHelper
      
      def self.tag(name, options = nil, open = false)
        "<#{name}#{tag_options(options) if options}" + (open ? ">" : " />")
      end
      
      def self.content_tag(name, content, options = nil)
        tag = "<#{name}#{tag_options(options)}>#{content}</#{name}>"
        tag = tag.html_safe if tag.respond_to?(:html_safe)
        tag
      end
      
      
      private
      
      
      def self.tag_options(options)
        unless options.blank?
          attrs = []
          attrs = options.map { |key, value| %(#{key}="#{value}") }
          " #{attrs.sort * ' '}" unless attrs.empty?
        end
      end
      
    end
    
  end
end
