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


    context 'field is updateable' do

      let(:desc) { { 'name' => :indentifier, 'updateable' => true } }
      let(:name) { desc['name'] }

      before { klass.field(desc) }

      it 'add desc to fields' do
        klass.fields[name.to_s].should == desc.merge('method_name' => name.to_s)
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

    context 'name is not updateable' do

      let(:desc) { { 'name' => :fubar, 'updateable' => false } }
      let(:name) { desc['name'] }

      before { klass.field(desc) }

      it 'creates a getter' do
        klass.new.should respond_to name
      end

      it 'creates no setter' do
        klass.new.should_not respond_to("#{name}=")
      end
    end

  end
end
