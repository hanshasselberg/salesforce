module Salesforce
  class Configuration

    attr_accessor :username, :password, :token, :client_id, :client_secret
    attr_reader :access_token_url, :grant_type, :service_path

    def initialize
      @access_token_url = 'https://login.salesforce.com/services/oauth2/token'
      @grant_type = 'password'
      @service_path = "/services/data/#{Salesforce::SF_API_VERSION}"
    end
  end
end
