require 'spec_helper'

describe Salesforce::Description::Fields do

  let(:mod) { Salesforce::Description::Fields}
  let(:klass) { Account }

  describe '.fields_description_for' do

    specify { mod.fields_description_for(klass.ressource_name).should be_a(Array) }

  end

  describe '.description_for' do

    specify { mod.description_for(klass.ressource_name).should be_a(Hash) }

  end

  describe '.url' do

    specify { mod.url(klass.ressource_name).should be_a(String) }
  end
end
