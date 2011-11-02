module Salesforce
  module Attributes
    module Processing
      extend ActiveSupport::Concern

      def process(attrs = nil)
        attrs ||= {}
        attrs = sanitize_from_salesforce(attrs)
        attrs.each_pair do |key, value|
          process_attribute(key, value)
        end
      end

      protected

      def process_attribute(name, value)
        send("#{name}=", value)
      end

      def sanitize_from_salesforce(attrs)
        Hash.new.tap do |new_attrs|
          attrs.each do |name, value|
            next if name == 'attributes'
            p name.to_s.underscore
            new_attrs[name.to_s.underscore] = value
          end
        end
      end

    end
  end
end
