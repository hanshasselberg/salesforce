module Salesforce
  module Persistence
    extend ActiveSupport::Concern

    def save
      self.class.persist_object(self)
    end

    module ClassMethods

      def find(id)
        attr = Connection.
          request(Description::Objects.object_url(ressource_name, id))
        new(attr)
      end

    end

  end
end
