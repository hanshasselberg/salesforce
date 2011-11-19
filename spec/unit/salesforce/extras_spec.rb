require 'spec_helper'

describe Salesforce::Extras do

  describe '.ressource_name' do

    let(:klass) { Account }

    specify { klass.should respond_to(:ressource_name) }

    context 'no name was set' do

      specify { klass.ressource_name.should == klass.name }

    end

    context 'a name was set' do

      let(:name) { 'fubar' }
      before do
        klass.ressource_name = name
      end

      specify { klass.ressource_name.should == name}

    end

  end

end
