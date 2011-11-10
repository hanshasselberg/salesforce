module Salesforce
  module Ressource
    extend ActiveSupport::Concern

    include ActiveModel::Serializers::JSON
    include Salesforce::Description
    include Salesforce::Attributes
    include Salesforce::Persistence
    include Salesforce::Connection
    include Salesforce::Fields
    include Salesforce::Serialization

    attr_reader :new_record

    def initialize(attrs = nil, options = nil)
      @new_record = true
      @attributes ||= {}
      options ||= {}
      process(attrs)
    end

    module ClassMethods

      def type
        'Account'
      end

    end

  end
end
