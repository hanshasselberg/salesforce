require 'spec_helper'
require 'account'

describe Salesforce::Extras do

  describe '.ressource_name' do

    let(:klass) { Account }
    let(:name) { 'fubar' }

    specify { klass.should respond_to(:ressource_name) }

    before do
      klass.ressource_name = name
    end

    specify { klass.ressource_name.should == name}
  end

end
