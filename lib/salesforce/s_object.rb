module Salesforce
  module SObject
    extend ActiveSupport::Concern

    include Salesforce::Attributes
    include Salesforce::Persistence
    include Salesforce::Connection
    include Salesforce::Fields

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
