# Overview

This gem is currently developed! Nothing works as expected and there's a lot missing.
Usage description is more a vision than reality! Feel free to make pull requests, they are
very welcome!

## About Salesforce

Salesforce is a gem to access Salesforce Rest API.

## Features

* Uses Rest API
* Discovers fields on its own
* Gets out of your way!

## Usage assuming you are using Rails

Provide credentials.

```ruby
# config/initializers/salesforce.rb
Salesforce.configure do |config|
  config.username = 'user'
  config.password = 'pw'
  config.client_id = 'client_id'
  config.client_secret = 'client_secret'
end
```

Mark classes.

```ruby
# app/models/account.rb
#
class Account
  include Salesforce::SObject
end

# app/models/product.rb
# with custom object
#
class Product
  include Salesforce::Object
  stored_in :Product__c
end
```
