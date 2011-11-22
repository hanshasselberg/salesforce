module Salesforce
  module Description
    module Fields

      def self.url(ressource_name)
        Objects.describe_url(ressource_name)
      end

      def self.description_for(ressource_name)
        return default_description[ressource_name] if Salesforce.configuration.use_defaults

        @description ||= {} #ini
        desc = @description[ressource_name]
        return desc if desc # early return

        @description[ressource_name] = Connection.request(
          url(ressource_name)
        )
      end

      def self.fields_description_for(ressource_name)
        description_for(ressource_name)["fields"]
      end

      private

      def self.default_description
        { 'Account' =>
          {
            "name" => "Account",
            "fields" =>
            [
              {
                  "length" => 18,
                  "name" => "Id",
                  "type" => "id",
                  "defaultValue" => { "value" => nil },
                  "updateable" => false,
                  "label" => "Account ID"
              }
            ],
            "updateable" => true,
            "label" => "Account",
            "keyPrefix" => "001",
            "custom" => false,
            "urls" =>
            {
              "uiEditTemplate" => "https://na1.salesforce.com/{ID}/e",
              "sobject" => "/services/data/v20.0/sobjects/Account",
              "uiDetailTemplate" => "https://na1.salesforce.com/{ID}"
            },
            "childRelationships" =>
            [
              {
                "field" => "ParentId",
                "deprecatedAndHidden" => false
              },
            ],
            "createable" => true,
            "customSetting" => false
          }
        }
      end

    end
  end
end
