module Salesforce
  module Ressource
    extend ActiveSupport::Concern

    include ActiveModel::Serializers::JSON
    include Salesforce::Attributes
    include Salesforce::Persistence
    include Salesforce::Connection
    include Salesforce::Fields
    include Salesforce::Serialization

    attr_reader :new_record

    included do
      cattr_accessor :ressource_name
      self.ressource_name = self.name
    end

    def initialize(attrs = nil, options = nil)
      @new_record = true
      @attributes ||= {}
      options ||= {}
      apply_defaults
      process(attrs)
    end

    module ClassMethods

      def stored_in(name)
        self.ressource_name = name
      end

    end

  end
end
