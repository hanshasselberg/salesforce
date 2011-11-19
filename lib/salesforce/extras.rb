module Salesforce
  module Extras
    extend ActiveSupport::Concern

    included do
      cattr_accessor :ressource_name
    end

    module ClassMethods

      def stored_in(name)
        self.ressource_name = name
      end

    end

  end
end
