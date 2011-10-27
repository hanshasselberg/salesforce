module Salesforce
  class Configuration
    def initialize(options = {})
      [:user, :password, :token].each do |option|
        instance_variable_set("@#{option}", options[option])
      end
    end
  end
end
