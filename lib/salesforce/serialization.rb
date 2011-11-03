module Salesforce
  module Serialization
    extend ActiveSupport::Concern

    def serializable_hash(options = nil)
      Hash[fields.map{ |k, v| [k, send(v[:method_name])] }.select{|e| e.last.present?}]
    end

  end
end
