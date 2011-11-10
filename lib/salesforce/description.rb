require 'salesforce/description/api_versions'
require 'salesforce/description/objects'
require 'salesforce/description/fields'

module Salesforce
  module Description
    extend ActiveSupport::Concern

    include ApiVersions
    include Objects
    include Fields

  end
end
