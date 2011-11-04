module Salesforce
  module Persistence
    extend ActiveSupport::Concern

    def save
      self.class.persist_object(self)
    end

    module ClassMethods

      def find(id)
        request_object(id)
      end

    end

  end
end
