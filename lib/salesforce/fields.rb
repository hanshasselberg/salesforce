module Salesforce
  module Fields
    extend ActiveSupport::Concern

    module ClassMethods

      def discovery
        return if Salesforce.configuration.disable_discovery

        fields = self.request_description["fields"]
      end

    end

  end
end
