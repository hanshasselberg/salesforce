# Overview

## About Salesforce

Salesforce is a gem to access Salesforce Rest API.

## Usage assuming you are using Rails

Provide credentials.

     # config/initializers/salesforce.rb
     Salesforce.configure do |config|
       config.username = 'user'
       config.password = 'pw'
       config.client_id = 'client_id'
       config.client_secret = 'client_secret'
     end

Mark classes.

     # app/models/account.rb
     # with custom mapping
     #
     class Account
       include Salesforce::Object
       field :umsatz2__c, :as => revenue # mapping
     end

     # app/models/product.rb
     # with custom object
     #
     class Product
       include Salesforce::Object
       stored_in :Product__c
     end
