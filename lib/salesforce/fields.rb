module Salesforce
  module Fields
    extend ActiveSupport::Concern

    module ClassMethods

      def discover
        return if Salesforce.configuration.disable_discover
      end

      def describe

      end
    end
  end
end
