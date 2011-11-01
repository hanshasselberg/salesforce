module Salesforce
  module Attributes
    extend ActiveSupport::Concern

    def attributes
      @attributes ||= {}
    end
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

  end
end
