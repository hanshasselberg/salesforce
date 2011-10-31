module Salesforce
  module Persistence
    extend ActiveSupport::Concern

    module ClassMethods

      def find(id)
        response = request(object_url(id))
        body = JSON.parse(response.body).first
        raise SalesforceError.new("#{body['errorCode']}: #{body['message']}") unless response.code == 200
        response
      end

      private

      def object_url(id)
        Salesforce.configuration.service_url + "/sobjects/#{self.type}/#{id}"
      end

      def request(url)
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
