require 'spec_helper'

describe Salesforce::Fields do

  let(:klass) { Account }

  let(:mod) { klass.send(:generated_field_methods) }

  describe '.discovery' do

    let(:description) { {
      "name" => "Account",
      "fields" =>
      [
        {
          "length" => 18,
          "name" => "Id",
          "type" => "id",
          "defaultValue" => { "value" => null }
        }
      ]}
    }
  end

  describe '.field' do

    before { klass.field(:identifier) }

    it 'creates a getter' do
      klass.new.should respond_to(:identifier)
    end

    it 'creates a setter' do
      klass.new.should respond_to(:identifier=)
    end

  end
end
