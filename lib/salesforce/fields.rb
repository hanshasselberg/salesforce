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
        request_description['fields'].each do |desc|
          field(desc['name'])
        end
      end

      def field(name, options = {})
        add_field(name.to_s.underscore, options)
      end

      def fields
        @fields ||= {}
      end

      def fields=(fields)
        @fields = fields
      end

      protected

      def add_field(name, options = {})
        meth = options.delete(:as) || name
        fields[name] = create_field(name, options)
        create_accessors(name, meth, options)
      end

      def create_field(name, options)
        { :cast_to => nil }
      end

      def create_accessors(name, meth, options)
        field = fields[name]
        generated_field_methods.module_eval do |klass|
          define_method(meth) do
            read_attribute(name)
          end
          define_method("#{meth}=") do |value|
            write_attribute(name, value)
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
