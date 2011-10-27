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

  end
end
