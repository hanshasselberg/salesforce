module Salesforce
  module SObject

    module ClassMethods
    end

    module InstanceMethods
    end

    def self.included(klass)
      klass.extend ClassMethods
      klass.send :include, InstanceMethods
    end

  end
end
