module Salesforce
  module Fields
    extend ActiveSupport::Concern

    included do
      discovery
    end

    def fields
      self.class.fields
    end

    module ClassMethods

      def discovery
        return if Salesforce.configuration.disable_discovery
        description['fields'].each do |desc|
          field(desc)
        end
      end

      def field(desc, options = {})
        add_field(desc, options)
      end

      def fields
        @fields ||= {}
      end

      def fields=(fields)
        @fields = fields
      end

      protected

      def add_field(desc, options = {})
        name = desc['name'].to_s
        fields[name] = create_field(desc, options)
        create_accessors(name, options)
      end

      def create_field(desc, options)
        desc.merge 'method_name' => desc['name'].to_s.underscore
      end

      def create_accessors(name, options)
        field = fields[name]
        method_name = field['method_name']
        generated_field_methods.module_eval do |klass|
          define_method(method_name) do
            read_attribute(method_name)
          end
          define_method("#{method_name}=") do |value|
            write_attribute(method_name, value)
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
