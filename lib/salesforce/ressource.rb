module Salesforce
  module Ressource
    extend ActiveSupport::Concern

    include ActiveModel::Serializers::JSON
    include Salesforce::Attributes
    include Salesforce::Extras
    include Salesforce::Persistence
    include Salesforce::Fields
    include Salesforce::Serialization

    attr_reader :new_record

    included do
      self.ressource_name = self.name
    end

    def initialize(attrs = nil, options = nil)
      @new_record = true
      @attributes ||= {}
      options ||= {}
      apply_defaults
      process(attrs)
    end

  end
end
