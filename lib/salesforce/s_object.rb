module Salesforce
  module SObject
    extend ActiveSupport::Concern
    include Salesforce::Persistence

    module ClassMethods

      def type
        'Account'
      end

    end

    module InstanceMethods

      def initialize(attributes = {})
        unless attributes['attributes']['type']==self.class.type
          return SalesforceError("something is wrong!")
        end
        if attributes['attributes'] != nil
          (class << self; self; end).class_eval do
            attributes.each do |name, value|
              next if name == 'attributes'
              next if value.nil? || value == ''
              method_name = "#{name.downcase}"
              value = value[0..-4] if method_name == 'Id'
              p "#{method_name}: #{value}"
              define_method method_name do
                return value
              end
            end
          end
        end
      end

    end

  end
end
