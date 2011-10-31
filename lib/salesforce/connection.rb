module Salesforce
  module Connection
    extend ActiveSupport::Concern

    module ClassMethods

      private

      def object_url(id)
        Salesforce.configuration.service_url + "/sobjects/#{self.type}/#{id}"
      end

      def description_url
        Salesforce.configuration.service_url + "/sobjects/#{self.type}/describe"
      end

      def request(id)
        response = request_data(object_url(id))
        body = JSON.parse(response.body)
        unless response.code == 200
          raise SalesforceError.new("#{body.first['errorCode']}: #{body.first['message']}")
        end
        Account.new(body)
      end

      def request_data(url)
        Typhoeus::Request.get(
          url,
          :headers => headers
        )
      end

      def headers
        {
          'Authorization' => "OAuth #{Salesforce.configuration.access_token}",
          'Content-Type' => 'application/json; charset=UTF-8',
          'Accept' => 'application/json'
        }
      end

    end

  end
end
