# encoding: utf-8

require 'typhoeus'
require 'json'
require 'salesforce/configuration'
require 'salesforce/sobject'

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
