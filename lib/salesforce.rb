# encoding: utf-8

require 'typhoeus'
require 'active_support/concern'
require 'active_support/core_ext'
require 'active_model'

require 'salesforce/attributes'
require 'salesforce/configuration'
require 'salesforce/connection'
require 'salesforce/description'
require 'salesforce/fields'
require 'salesforce/persistence'
require 'salesforce/serialization'
require 'salesforce/ressource'

module Salesforce #:nodoc
  include Description::ApiVersions

  class SalesforceError < StandardError
    def initialize(message)
      super(message)
    end
  end

  attr_reader :configuration

  def self.configure
    block_given? ? yield(configuration) : configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end
end
