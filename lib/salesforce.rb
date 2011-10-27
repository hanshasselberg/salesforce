# encoding: utf-8

require 'salesforce/configuration'

module Salesforce #:nodoc
  extend self

  def configure
    block_given? ? yield(Configuration) : Configuration
  end

  def configuration
    @configuration ||= Configuration.new
  end
end
