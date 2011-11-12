module Salesforce
  module Description
    module Fields

      def self.description_url(klass)
        "/services/data/#{ApiVersions.latest}/sobjects/#{klass}/describe"
      end

      def self.description(klass)
        @description ||= {} #init
        desc = @description[klass]
        return desc if desc # early return
        @description[klass] = Connection.request(
          description_url(klass)
        )

      end

      private

      def self.default_description(klass)
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
