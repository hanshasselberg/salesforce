module Salesforce
  module Persistence
    extend ActiveSupport::Concern

    def save
      self.class.persist_object(self)
    end

  end
end
