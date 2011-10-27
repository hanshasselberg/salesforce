module Salesforce
  class Connection

    def access_token
      response['access_token']
    end

    def instance_url
      response['instance_url']
    end

    def service_url
      instance_url + Salesforce.configuration.service_path
    end

    def reset
      @response = nil
    end

    private

    def response
      @response ||= request_credentials
    end

    def credentials
      {
        :grant_type => Salesforce.configuration.grant_type,
        :client_id => Salesforce.configuration.client_id,
        :client_secret => Salesforce.configuration.client_secret,
        :username => Salesforce.configuration.username,
        :password => Salesforce.configuration.password
      }
    end

    def request_credentials
      response = Typhoeus::Request.post(
        Salesforce.configuration.access_token_url, :query => credentials)

      raise "Couldn't request token" unless response.code == 200

      essentials = ['instance_url', 'access_token']
      url_and_token = response.keep_if { |key, value| essentials.include? key }

      # Salesforce doesn't seems to like requests straight after a token request
      sleep 3

      url_and_token
    end
  end
end
