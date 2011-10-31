module Salesforce
  module Persistence
    extend ActiveSupport::Concern

    module ClassMethods

      def find(id)
        request(id)
      end

    end

  end
end
