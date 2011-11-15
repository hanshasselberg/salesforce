require 'spec_helper'

describe Salesforce::Description::Fields do

  describe '.objects' do

    let(:mod) { Salesforce::Description::Fields}
    let(:klass) { Account }

    specify { mod.description(klass.ressource_name).should be_a(Array) }

  end
end
