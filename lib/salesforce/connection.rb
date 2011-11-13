module Salesforce
  module Connection

    def self.request(url, options = {})
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

    def self.default_headers
      {
        'Content-Type' => 'application/json; charset=UTF-8',
        'Accept' => 'application/json',
        'X-PrettyPrint' => 1
      }
    end

    def self.auth_headers
      { 'Authorization' => "OAuth #{Salesforce.configuration.access_token}" }
    end

  end
end
