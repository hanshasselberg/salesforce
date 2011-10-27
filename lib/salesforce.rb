# encoding: utf-8

require 'salesforce/configuration'

module Salesforce #:nodoc
  extend self
  @configuration = Configuration.new

  def configure
    block_given? ? yield(configuration) : configuration
  end

  def configuration
    @configuration
  end
end
