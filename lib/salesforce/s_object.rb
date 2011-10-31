module Salesforce
  module SObject
    extend ActiveSupport::Concern
    include Salesforce::Persistence

    module ClassMethods

      def type
        'Account'
      end

    end

  end
end
