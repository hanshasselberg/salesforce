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

      def description
        @ressource_description ||= request_data(description_url)
      end

      def persist_object(o)
        # send_data o
      end

      private

      def send_data(o)
        method = o.new_record ? :post : :put
        response = request(url, :method => method, :body => o.serializable_hash.to_json.to_s)
        body = JSON.parse(response.body)
        unless response.code == 201
          raise SalesforceError.new("#{body.first['errorCode']}: #{body.first['message']}")
        end
        o.id = body['id']
        o
      end

      def request_data(url)
        response = request(url, :method => :get)
        body = JSON.parse(response.body)
        unless response.code == 200
          raise SalesforceError.new("#{body.first['errorCode']}: #{body.first['message']}")
        end
        body
      end

      def request(url, options = {})
        request = Typhoeus::Request.new(url, options.merge(headers))
        hydra = Typhoeus::Hydra.new
        hydra.queue(request)
        hydra.run
        request.response
      end

      def headers
        {:headers =>
          {
            'Authorization' => "OAuth #{Salesforce.configuration.access_token}",
            'Content-Type' => 'application/json; charset=UTF-8',
            'Accept' => 'application/json'
          }
        }
      end

    end

  end
end
