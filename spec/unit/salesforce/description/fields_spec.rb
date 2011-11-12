require 'spec_helper'
require 'account'

describe Salesforce::Description::Fields do

  describe '.objects' do

    let(:mod) { Salesforce::Description::Fields}
    let(:klass) { Account }

    before do
      mod.instance_variable_set(
        :@description,
        Account => mod.send(
          :default_description,
          Account
        )
      )
    end
    specify { mod.description(klass).should be_a(Array) }

  end
end
