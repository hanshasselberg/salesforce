$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

MODELS = File.join(File.dirname(__FILE__), "app/models")
$LOAD_PATH.unshift(MODELS)

require 'salesforce'

Salesforce.configure do |config|
  config.disable_discovery = true
  config.use_defaults = true
  config.access_token = '123'
  config.instance_url = 'http://www.sf.com'
end

Dir[ File.join(MODELS, "*.rb") ].sort.each { |file| require File.basename(file) }

RSpec.configure do |config|

  # ressource name not resetted caused a lot trouble!
  config.before :each do
    Account.ressource_name = 'Account'
    Opportunity.ressource_name = 'Opportunity'
  end

end

