module Salesforce
  module Connection
    extend ActiveSupport::Concern

    module ClassMethods

      def object_url(id)
        Salesforce.configuration.service_url + "/sobjects/#{name}/#{id}"
      end

      def description_url
        Salesforce.configuration.service_url + "/sobjects/#{name}/describe"
      end

      def request_object(id)
        new request_data(object_url(id))
      end

      def request_description
        request_data(description_url)
      end

      private

      def request_data(url)
        response = Typhoeus::Request.get(
          url,
          :headers => headers
        )
        body = JSON.parse(response.body)
        unless response.code == 200
          raise SalesforceError.new("#{body.first['errorCode']}: #{body.first['message']}")
        end
        body
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