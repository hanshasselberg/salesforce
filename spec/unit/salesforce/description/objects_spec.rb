require 'spec_helper'
require 'account'

describe Salesforce::Description::Objects do

  describe '.objects' do

    let(:mod) { Salesforce::Description::Objects }
    let(:klass) { Account }

    before do
      mod.instance_variable_set(
        :@description,
        mod.send( :default_description )
      )
    end

    specify { mod.description.should be_a(Hash) }

  end
end
