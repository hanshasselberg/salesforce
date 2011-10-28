module Salesforce
  module SObject

    module ClassMethods

      def where(options = {})
        ids = [options[:id]].flatten
        []
      end

      def type
        'sfAccount'
      end

      private

      def object_url(id)
        Salesforce.configuration.service_url + "/sobjects/#{self.type}/#{id}"
      end

      def request(url)
        response = Typhoeus::Request.get(
          configuration.service_url + url,
          :headers => { 'Authorization' => "OAuth #{configuration.access_token}" }
        )
      end

    end

    module InstanceMethods
    end

    def self.included(klass)
      klass.extend ClassMethods
      klass.send :include, InstanceMethods
    end

  end
end
