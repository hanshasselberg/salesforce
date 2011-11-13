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
        new request(object_url(id))
      end

      def description
        @ressource_description ||= request(description_url)
      end

      def request(url, options = {})
        options[:method] ||= :get
        options[:headers] ||= {}
        options[:headers].merge!(default_headers)
        options[:headers].merge!(auth_headers) if not options.delete(:no_auth)
        options.merge! :verbose => true
        request = Typhoeus::Request.new(url, options)
        hydra = Typhoeus::Hydra.hydra
        hydra.queue(request)
        hydra.run
        response = request.response
        body = JSON.parse(response.body)
        unless response.code == 200
          raise SalesforceError.new("#{body.first['errorCode']}: #{body.first['message']}")
        end
        body
      end

      def default_headers
        {
          'Content-Type' => 'application/json; charset=UTF-8',
          'Accept' => 'application/json',
          'X-PrettyPrint' => 1
        }
      end

      def auth_headers
        { 'Authorization' => "OAuth #{Salesforce.configuration.access_token}" }
      end

    end
    extend ClassMethods

  end
end
