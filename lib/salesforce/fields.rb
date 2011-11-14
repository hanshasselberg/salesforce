module Salesforce
  module Fields
    extend ActiveSupport::Concern

    included do
      discovery unless Salesforce.configuration.disable_discovery
    end

    def fields
      self.class.fields
    end

    def defaults
      self.class.defaults
    end

    module ClassMethods

      def discovery
        Description::Fields.description(self.ressource_name).each do |desc|
          field(desc)
        end
      end

      def field(desc, options = {})
        if desc.is_a?(String) || desc.is_a?(Symbol)
          desc = {
            'name' => desc.to_s,
            'updateable' => true,
            'defaultValue' => { 'value' => nil }
          }
        end
        add_field(desc, options)
      end

      def fields
        @fields ||= {}
      end

      def fields=(fields)
        @fields = fields
      end

      def defaults
        @defaults ||= []
      end

      def defaults=(defaults)
        @defaults = defaults
      end

      protected

      def add_field(desc, options = {})
        name = desc['name'].to_s.underscore
        fields[name] = create_field(desc, options)
        defaults << name
        create_accessors(name, options)
      end

      def create_field(desc, options)
        desc.merge 'method_name' => desc['name'].to_s.underscore
      end

      def create_accessors(name, options)
        field = fields[name]
        method_name = field['method_name']
        generated_field_methods.module_eval do |klass|
          # p field.inspect
          define_method(method_name) do
            read_attribute(method_name)
          end
          if field['updateable']
            define_method("#{method_name}=") do |value|
              write_attribute(method_name, value)
            end
          end
        end
      end

      def generated_field_methods
        @generated_field_methods ||= begin
          Module.new.tap do |mod|
            include mod
          end
        end
      end

    end

  end
end
