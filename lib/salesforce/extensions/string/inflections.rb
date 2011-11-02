module Salesforce
  module Extensions
    module String
      module Inflections

        def underscore
          self.gsub(/::/, '/').
            gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
            gsub(/([a-z\d])([A-Z])/,'\1_\2').
            tr("-", "_").
            downcase
        end

      end
    end
  end
end
