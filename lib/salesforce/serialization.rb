module Salesforce
  module Serialization
    extend ActiveSupport::Concern

    def serializable_hash(options = nil)
      options ||= {}

      only = Array.wrap(options[:only]).map(&:to_s)
      except = Array.wrap(options[:except]).map(&:to_s)

      field_names = fields.keys.map(&:to_s)
      if only.any?
        field_names &= only
      elsif except.any?
        field_names -= except
      end

      array = fields.
        select{ |k, v| field_names.include?(k) }.
        map{ |k, v| [k, send(v[:method_name])] }.
        select{ |e| e.last.present?}
      Hash[array]
    end

  end
end
