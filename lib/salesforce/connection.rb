module Salesforce
  module Connection
    extend ActiveSupport::Concern

    module ClassMethods

      def base_url
        Salesforce.configuration.service_url + "/sobjects/#{name}"
      end

      def object_url(id)
        "#{base_url}/#{id}"
      end

      def description_url
        "#{base_url}/describe"
      end

      def request_object(id)
        new request_data(object_url(id))
      end

      def request_description
        request_data(description_url)
      end

      def persist_object(o)
        send_data o
      end

      private

      def send_data(o)
        request = Typhoeus::Request.new(
          base_url,
          :method => o.new_record ? :post : :put,
          :headers => headers,
          :body => o.serializable_hash.to_json.to_s
        )
        hydra = Typhoeus::Hydra.new
        hydra.queue(request)
        hydra.run

        response = request.response
        body = JSON.parse(response.body)
        unless response.code == 201
          raise SalesforceError.new("#{body.first['errorCode']}: #{body.first['message']}")
        end
        o.id = body['id']
        o
      end

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
