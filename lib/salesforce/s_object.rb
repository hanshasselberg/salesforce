module Salesforce
  module SObject
    extend ActiveSupport::Concern

    include Salesforce::Attributes
    include Salesforce::Persistence
    include Salesforce::Connection
    include Salesforce::Fields

    module ClassMethods

      def type
        'Account'
      end

    end

    module InstanceMethods

      def initialize(attrs = {})
        if attrs && attrs['attributes'] != nil
          attrs.each do |name, value|
            next if name == 'attributes'
            next if value.nil? || value == ''
            method_name = "#{name.downcase}"
            value = value[0..-4] if method_name == 'Id'
            send("#{method_name}=", value)
          end
        end
      end

    end

  end
end
