module Salesforce
  module SObject

    def ==(other)
      self.class == other.class && id == other.id
    end

  end
end
