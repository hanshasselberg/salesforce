require 'spec_helper'
require 'account'

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
          "defaultValue" => { "value" => nil},
          "updateable" => false
        }
      ]}
    }

    context 'fields are discovered' do

      it 'responds_to id' do
        klass.new.should respond_to(:id)
      end

    end

  end

  describe '.field' do

    let!(:name) { :identifier }
    before { klass.field(name) }

    it "adds to fields" do
      klass.fields.should include(name.to_s)
    end

    it 'creates a getter' do
      klass.new.should respond_to(name)
    end

    it 'creates a setter' do
      klass.new.should respond_to("#{name}=")
    end

    it 'returns assigned value' do
      klass.new.tap do |o|
        o.send "#{name}=", 42
        o.send(name).should == 42
      end
    end

  end
end
