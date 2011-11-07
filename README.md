# Overview

This little gem provides elegant access to the Salesforce [REST API](http://www.salesforce.com/us/developer/docs/api_rest/index.htm).

## About Salesforce

The gem tries to handle as much as possible for you. Provide a configuration, ```include Salesforce::Ressource``` 
and you are ready to go! At this time the available fields are already discovered and getters generated. At the moment
only date fields are casted, others are god ol' strings.

## Usage

```ruby

Salesforce.configure do |config|
  config.username = 'user'
  config.password = 'pw'
  config.client_id = 'client_id'
  config.client_secret = 'client_secret'
end

class Account
  include Salesforce::Ressource
end

account = Account.find('001U0000005cy3yIAA')
account.id 
#=> '001U0000005cy3yIAA'

account.attributes
#=> 
```
