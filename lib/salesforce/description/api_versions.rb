module Salesforce
  module Description
    module ApiVersions
      extend ActiveSupport::Concern

      module ClassMethods

        def url
          'http://na1.salesforce.com/services/data/'
        end

        def default_api_versions
          [
            { 'url' => '/services/data/v23.0', 'version' => '23.0', 'label' => 'Winter' }
          ]
        end

        def latest_api_version
          @latest_api_version ||= api_versions.
            max_by { |e| e['version'] }
        end

        def api_versions
          @api_versions ||= begin
            if Salesforce.configuration.disable_discovery
              default_api_versions
            else
              Connection.request(url, :no_auth => true)
            end
          end
        end

      end

    end
  end
end
