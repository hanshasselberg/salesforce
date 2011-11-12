module Salesforce
  module Serialization
    extend ActiveSupport::Concern

    def serializable_hash(options = nil)
      options ||= {}

      only = Array.wrap(options[:only]).map(&:to_s)
      except = Array.wrap(options[:except]).map(&:to_s)

      field_names = fields.values.map{ |f| f['name'].to_s }

      if only.any?
        field_names &= only
      elsif except.any?
        field_names -= except
      end

      array = fields.
        select{ |k, v| field_names.include?(v['name']) }.
        map{ |k, v| [v['name'], send(v['method_name'])] }.
        select{ |e| e.last.present?}
      Hash[array]
    end

  end
end
