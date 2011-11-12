module Salesforce
  module Description
    module Objects

      def self.url
        "/services/data/#{api_version}/sobjects"
      end

      def self.description
        @description ||= Connection.request(@url)
      end

      private

      def self.default_description
        {
          "encoding" => "UTF-8",
          "maxBatchSize" => 200,
          "sobjects" => [ {
            "name" => "Account",
            "label" => "Account",
            "custom" => false,
            "keyPrefix" => "001",
            "updateable" => true,
            "searchable" => true,
            "labelPlural" => "Accounts",
            "layoutable" => true,
            "activateable" => false,
            "urls" => {
              "sobject" => "/services/data/v23.0/sobjects/Account",
              "describe" => "/services/data/v23.0/sobjects/Account/describe",
              "rowTemplate" => "/services/data/v20.0/sobjects/Account/{ID}"
            },
            "createable" => true,
            "customSetting" => false,
            "deletable" => true,
            "deprecatedAndHidden" => false,
            "feedEnabled" => false,
            "mergeable" => true,
            "queryable" => true,
            "replicateable" => true,
            "retrieveable" => true,
            "undeletable" => true,
            "triggerable" => true
          } ]
        }
      end

    end
  end
end
