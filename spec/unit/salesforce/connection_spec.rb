require 'spec_helper'

describe Salesforce::Connection do

  let(:klass) { Account }

  describe '#persist_object' do

    context 'given a new object' do

      let(:account) { klass.new(:name => 'Test') }

      it 'returns object' do
        klass.persist_object(account).should be_a(klass)
      end

      it 'writes valid id' do
        klass.persist_object(account).id.should be
      end

    end

  end

  describe '.request_object' do

    let(:id) { '001U0000005cy3yIAA' }
    let(:account) { Account.request_object(id) }

    context 'given a valid id' do

      it 'request_objects a sobject' do
        if ENV['SF_USERNAME']
          account.should be_a(Account)
        else
          pending 'ENV credentials missing.'
        end
      end

      it 'request_objects a sobject with correct id' do
        if ENV['SF_USERNAME']
          account.id.should == id
        else
          pending 'ENV credentials missing.'
        end
      end

    end

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

end
