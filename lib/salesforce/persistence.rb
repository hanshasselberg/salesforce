module Salesforce
  module Persistence
    extend ActiveSupport::Concern

    module ClassMethods

      def find(id)
        request_object(id)
      end

    end

  end
end
