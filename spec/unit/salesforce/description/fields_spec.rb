require 'spec_helper'

describe Salesforce::Description::Fields do

  describe '.objects' do

    let(:mod) { Salesforce::Description::Fields}
    let(:klass) { Account }

    before do
      desc = mod.send(
        :default_description,
        klass.ressource_name
      )
      mod.instance_variable_set(
        :@description,
        klass.ressource_name => desc
      )
    end

    specify { mod.description(klass.ressource_name).should be_a(Array) }

  end
end
