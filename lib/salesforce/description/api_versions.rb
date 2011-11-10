module Salesforce
  module Description
    module ApiVersions
      extend ActiveSupport::Concern

      module ClassMethods

        def api_version
          {
            'url' => '/services/data/v23.0',
            'version' => '23.0',
            'label' => 'Winter'
          }
        end

      end

    end
  end
end
