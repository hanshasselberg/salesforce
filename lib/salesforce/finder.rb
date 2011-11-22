module Salesforce
  module Finder
    extend ActiveSupport::Concern

    module ClassMethods

      def find(id)
        attr = Connection.
          request(Description::Objects.object_url(ressource_name, id))
        new(attr)
      end

    end

  end
end
