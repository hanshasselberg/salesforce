# encoding: utf-8

require 'salesforce/configuration'
require 'salesforce/connection'

module Salesforce #:nodoc

  attr_reader :configuration

  SF_API_VERSION = "v22.0"

  def self.configure
    block_given? ? yield(configuration) : configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end
end
