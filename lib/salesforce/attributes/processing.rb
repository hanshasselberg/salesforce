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
        value = fix_data_type(value)
        send("#{name}=", value)
      end

      def sanitize_from_salesforce(attrs)
        Hash.new.tap do |new_attrs|
          attrs.each do |name, value|
            next if name == 'attributes'
            new_attrs[name.to_s.underscore] = value
          end
        end
      end

      def fix_data_type(input)
        if input =~ /^\d{4}-\d{2}-\d{2}/
          input = DateTime.parse(input)
        end

        if input.kind_of?(Date) || input.kind_of?(DateTime)
          input = input.to_time.utc
        end

        input
      end

    end
  end
end
