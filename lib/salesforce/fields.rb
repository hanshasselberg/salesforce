module Salesforce
  module Fields
    extend ActiveSupport::Concern

    included do
      # field(:_Id, :type => String)
      # alias :id :_Id
    end

    def fields
      self.class.fields
    end

    def method_missing(method, *args)
      p "hello: #{method}"
      method = method.to_s
      if method =~ /(.\w+)=$/ and fields.has_key?($1)
        return write_attribute($1, args.first)

      elsif fields.has_key?(method)
        return read_attribute(method)

      end
    end

    def respond_to?(method)
      if fields.has_key?(method.to_s.gsub('=',''))
        true
      else
        super
      end
    end

    module ClassMethods

      # def discovery
      #   return if Salesforce.configuration.disable_discovery

      #   fields = self.request_description["fields"]
      # end

      def field(name, options = {})
        add_field(name.to_s, options)
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
        # FIXME use this instead of method_missing!
        # create_accessors(name, meth, options)
      end

      def create_field(name, options)
        { :cast_to => String }
      end

      def create_accessors(name, meth, options)
        field = fields[name]
        generated_field_methods.module_eval do |klass|
          case field[:cast_to]
          when String
            define_method(meth) do
              read_attribute(name).to_s
            end
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
