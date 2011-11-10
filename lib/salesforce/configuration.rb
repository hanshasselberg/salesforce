module Salesforce
  class Configuration

    attr_accessor :username, :password, :client_id, :client_secret, :disable_discovery
    attr_reader :access_token_url, :grant_type, :service_path, :access_token, :instance_url

    def initialize
      @access_token_url = 'https://login.salesforce.com/services/oauth2/token'
      @grant_type = 'password'
      @disable_discovery = false
    end

    def service_path
      Salesforce.api_version['url']
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
      ask_salesforce unless @access_token
      @access_token
    end

    def instance_url
      ask_salesforce unless @instance_url
      @instance_url
    end

    def service_url
      instance_url + service_path
    end

    def reset
      @response = nil
    end

    def response
      @response ||= ask_salesforce
    end

    private

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
      @response = Typhoeus::Request.post(
        access_token_url,
        :params => credentials
      )
      body = JSON.parse(response.body)
      raise SalesforceError.new("#{body['error']}: #{body['error_description']}") if @response.code != 200
      @access_token = body['access_token']
      @instance_url = body['instance_url']
      @response
    end
  end
end
