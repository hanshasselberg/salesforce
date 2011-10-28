require 'spec_helper'

describe Salesforce::Configuration do

  let(:configuration) { Salesforce::Configuration.new }

  describe '.reset' do

    it 'removes previous cached response' do
      configuration.instance_variable_set(:@response, true)
      configuration.reset
      configuration.instance_variable_get(:@response).should eq(nil)
    end

  end

  describe 'salesforce interaction' do

    let(:body) {
      "{\"instance_url\":\"https://na12.salesforce.com\","+
      "\"access_token\":\"0RRR67FzynBSJI1lxuHomrSWgXe9\"}"
    }
    let(:response) { Typhoeus::Response.new(:code => 200, :body => body) }

    before :all do
      Typhoeus::Hydra.new.stub(:post, configuration.access_token_url).and_return(response)
    end

    describe '.ask_salesforce' do

      context 'given valid credentials' do

        it 'succeeds' do
          configuration.send(:ask_salesforce).success?.should be_true
        end

      end

    end

    describe '.request_credentials' do

      it 'stores access token' do
        configuration.access_token.should be
      end

      it 'stores instance url' do
        configuration.instance_url.should be
      end

    end

  end

end

