module Salesforce
  module SObject

    module ClassMethods

      def where(options = {})
        [1]
      end

    end

    module InstanceMethods
    end

    def self.included(klass)
      klass.extend ClassMethods
      klass.send :include, InstanceMethods
    end

  end
end
