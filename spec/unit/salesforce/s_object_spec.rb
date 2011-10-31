require 'spec_helper'

describe Salesforce::SObject do

  let(:klass) { Account }

  describe '.type' do

    specify { Account.type.should == 'Account'}

  end

  describe '.object_url' do

    context 'given an id' do
      let(:service_url) { "http://service.url" }

      specify do
        Salesforce.configuration.stub(:service_url){ service_url }
        result_url = service_url+"/sobjects/#{Account.type}/123"

        Account.send(:object_url, '123').should == result_url
      end

    end

  end

  describe 'create' do

  end

  describe '.find' do

    let(:id) { '001U0000005cy3y' }

    context 'given a valid id' do

      it 'finds a sobject' do
        a = Account.find(id)
        a.should be
      end

    end

  end

end
