# Overview

## About Salesforce

Salesforce is a gem to access Salesforce Rest API.

## Usage assuming you are using Rails

Provide credentials.
     # config/initializers/salesforce.rb
     Salesforce.configure do |config|
       config.user = 'user'
       config.pw = 'pw'
       config.token = 'token'
     end

Mark classes.
     # app/models/account.rb
     # with custom mapping
     #
     class Account
       include Salesforce::Object
       field :umsatz2__c, :type => Integer, :as => revenue # mapping
     end

     # app/models/product.rb
     # with custom object
     #
     class Product
       include Salesforce::Object
       stored_in :Product__c
     end
