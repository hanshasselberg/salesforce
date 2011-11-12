require "salesforce/attributes/processing"

module Salesforce
  module Attributes
    extend ActiveSupport::Concern
    include Processing

    attr_reader :attributes
    alias :raw_attributes :attributes

    def read_attribute(name)
      attributes[name.to_s]
    end
    alias :[] :read_attribute

    def respond_to?(*args)
      ( attributes && attributes.has_key?(args.first.to_s)) || super
    end

    def write_attribute(name, value)
      attributes[name.to_s] = value
    end
    alias :[]= :write_attribute

    def assign_attributes(attrs = nil, options = {})
      attrs.each do |name, value|
        write_attribute(name, value)
      end
    end

    def apply_defaults
      defaults.each do |name|
        unless attributes.has_key?(name)
          if field = fields[name]
            if field.has_key?('defaultValue')
              attributes[name] = field['defaultValue']['value']
            end
          end
        end
      end
    end

  end
end
