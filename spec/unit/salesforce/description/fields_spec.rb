require 'spec_helper'
require 'account'

describe Salesforce::Description::Fields do

  describe '.objects' do

    let(:mod) { Salesforce::Description::Fields}
    let(:klass) { Account }

    before do
      mod.instance_variable_set(
        :@description,
        klass.ressource_name => mod.send(
          :default_description,
          klass.ressource_name
        )
      )
    end

    specify { mod.description(klass.ressource_name).should be_a(Array) }

  end
end
