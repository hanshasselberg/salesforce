module Salesforce
  module Description
    module Fields

      def self.url(ressource_name)
        "/services/data/#{ApiVersions.latest}/sobjects/#{ressource_name}/describe"
      end

      def self.description(ressource_name)
        @description ||= {} #init
        desc = @description[ressource_name]
        return desc if desc # early return
        @description[ressource_name] = Connection.request(
          url(ressource_name)
        )

      end

      private

      def self.default_description(ressource_name)
        if ressource_name == 'Account'
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
