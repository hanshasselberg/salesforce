require 'spec_helper'

describe Salesforce::Fields do

  let(:klass) { Account }

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

      before do
        klass.discovery
      end

      it 'responds_to id' do
        klass.new.should respond_to(:id)
      end

    end

  end

  describe '.ressource_name' do

    specify { klass.should respond_to("ressource_name") }

    specify { klass.should respond_to("ressource_name=") }

  end

  describe '.field' do

    context 'field is updateable' do

      let(:desc) { { 'name' => :indentifier, 'updateable' => true, 'defaultValue' => { 'value' => nil } } }
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

      let(:desc) { { 'name' => :fubar, 'updateable' => false, 'defaultValue' => { 'value' => nil } } }
      let(:name) { desc['name'] }

      before { klass.field(desc) }

      it 'creates a getter' do
        klass.new.should respond_to name
      end

      it 'creates no setter' do
        klass.new.should_not respond_to("#{name}=")
      end

    end

    context 'name has default' do

      let(:desc) { { 'name' => :fubar, 'updateable' => false, 'defaultValue' => { 'value' => 1 } } }
      let(:name) { 'fubar' }

      before { klass.field(desc) }

      it 'defaults to 1' do
        klass.new.send(name).should == 1
      end

    end

  end
end
