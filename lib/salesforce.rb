# encoding: utf-8

require 'typhoeus'
require 'json'
require 'active_support/concern'
require 'active_support/core_ext'

require 'salesforce/configuration'
require 'salesforce/connection'
require 'salesforce/fields'
require 'salesforce/persistence'
require 'salesforce/attributes'
require 'salesforce/s_object'

module Salesforce #:nodoc

  class SalesforceError < StandardError
    def initialize(message)
      super(message)
    end
  end

  attr_reader :configuration

  SF_API_VERSION = "v22.0"

  def self.configure
    block_given? ? yield(configuration) : configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end
end
