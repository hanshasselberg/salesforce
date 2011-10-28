module Salesforce
  class Configuration

    attr_accessor :username, :password, :client_id, :client_secret
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
      instance_url + service_path
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
        :grant_type => grant_type,
        :client_id => client_id,
        :client_secret => client_secret,
        :username => username,
        :password => password
      }
    end

    def ask_salesforce
      Typhoeus::Request.post(
        access_token_url,
        :params => credentials
      )
    end

    def request_credentials
      response = ask_salesforce

      body = JSON.parse(response.body)
      raise SalesforceError.new("#{body['error']}: #{body['error_description']}") unless response.code == 200
      # FIXME
      # Salesforce doesn't seems to like requests straight
      # after a token request
      # sleep 3

      body.keep_if { |key, value|
        ['instance_url', 'access_token'].include? key
      }
    end
  end
end
