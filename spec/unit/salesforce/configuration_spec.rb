require 'spec_helper'

describe Salesforce::Configuration do

  let(:configuration) { Salesforce::Configuration.new }

  describe '.reset' do

    it 'removes previous cached response' do
      configuration.instance_variable_set(:@response, true)
      configuration.reset
      configuration.instance_variable_get(:@response).should == nil
    end

  end

  describe 'salesforce interaction' do

    describe '.ask_salesforce' do

      context 'given valid credentials' do

        specify{ configuration.send(:ask_salesforce).should be_success }

      end

    end

    describe '.request_credentials' do

      let(:response) { Typhoeus::Response.new(
        :code => 200,
        :body => "{\"instance_url\":\"a\",\"access_token\":\"b\"}")
      }
      before :each do
        configuration.stub(:ask_salesforce).and_return(response)
      end

      it 'stores access token' do
        configuration.access_token.should be
      end

      it 'stores instance url' do
        configuration.instance_url.should be
      end

    end

  end

end

