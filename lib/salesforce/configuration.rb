module Salesforce
  class Configuration

    attr_accessor :username, :password, :token, :client_id, :client_secret
    attr_reader :access_token_url, :grant_type, :service_path

    def initialize
      @access_token_url = 'https://login.salesforce.com/services/oauth2/token'
      @grant_type = 'password'
      @service_path = "/services/data/#{Salesforce::SF_API_VERSION}"
    end

    def username
      @username || ENV['SF_USERNAME']
    end

    def password
      @password || ENV['SF_PASSWORD']
    end

    def client_id
      @client_id || ENV['SF_CLIENT_ID']
    end

    def client_secret
      @client_secret || ENV['SF_CLIENT_SECRET']
    end

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
        Salesforce.configuration.access_token_url,
        :query => credentials
      )
      puts response.inspect

      raise "Couldn't request token" unless response.code == 200

      essentials = ['instance_url', 'access_token']
      url_and_token = response.keep_if { |key, value|
        essentials.include? key
      }

      # Salesforce doesn't seems to like requests straight
      # after a token request
      sleep 3

      url_and_token
    end
  end
end
