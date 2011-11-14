$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

MODELS = File.join(File.dirname(__FILE__), "app/models")
$LOAD_PATH.unshift(MODELS)

require 'salesforce'

# Dir[ File.join(MODELS, "*.rb") ].sort.each { |file| require File.basename(file) }

Salesforce.configure do |config|
  config.disable_discovery = true
end

RSpec.configure do |config|

  # config.before :all do
  #   Salesforce.instance_variable_set(
  #     :@api_versions,
  #     api_versions_dummy
  #   )
  # end

end

