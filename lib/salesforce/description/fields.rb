module Salesforce
  module Description
    module Fields
      extend ActiveSupport::Concern

      module ClassMethods

        def fields_description_url(klass)
          "/services/data/#{api_version}/sobjects/#{klass}/describe"
        end

        def fields_description(klass)
          @fields_description ||= {} #init
          desc = @fields_description[klass]
          return desc if desc # early return
          @fields_description[klass] = Connection.request(
            fields_description_url(klass)
          ) || default_fields_description(klass)

        end

        private

        def default_fields_description(klass)
          if klass == Account
            [
               {
                  "length" => 18,
                  "klass" => "Id",
                  "type" => "id",
                  "defaultValue" => { "value" => nil },
                  "updateable" => false,
                  "label" => "Account ID"
               }
            ]
          end
        end

      end
    end
  end
end
