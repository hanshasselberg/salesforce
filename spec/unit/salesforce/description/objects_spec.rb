require 'spec_helper'
require 'account'

describe Salesforce::Description::Objects do

  let(:mod) { Salesforce::Description::Objects }
  let(:klass) { Account }
  let(:id) { '123' }
  let(:object_url) { mod.object_url(klass.ressource_name, id)}

  describe '.objects' do

    specify { mod.description.should be_a(Hash) }

  end

  describe '.object_url' do

    specify do
      object_url.should eq(mod.send(:default_description)['sobjects'].first['urls']['rowTemplate'].gsub('{ID}', id))
    end

  end

  describe '.url' do

    specify { mod.url.should be }

  end

end
