$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

MODELS = File.join(File.dirname(__FILE__), "app/models")
$LOAD_PATH.unshift(MODELS)

require 'salesforce'

Salesforce.configure do |config|
  config.disable_discovery = true
end

Dir[ File.join(MODELS, "*.rb") ].sort.each { |file| require File.basename(file) }

RSpec.configure do |config|

  config.before :all do
    Salesforce.configuration.instance_variable_set(:@access_token, '123')
    Salesforce.configuration.instance_variable_set(:@instance_url, 'http://www.sf.com')
    mod = Salesforce::Description::Fields
    mod.instance_variable_set(
      :@description,
      'Account' => mod.send(
        :default_description,
        'Account'
      ),
      'Opportunity' => mod.send(
        :default_description,
        'Opportunity'
      )
    )
    mod = Salesforce::Description::Objects
    mod.instance_variable_set(
      :@description,
      mod.send( :default_description )
    )
  end

  # ressource name not resetted caused a lot trouble!
  config.before :each do
    Account.ressource_name = 'Account'
    Opportunity.ressource_name = 'Opportunity'
  end

end

