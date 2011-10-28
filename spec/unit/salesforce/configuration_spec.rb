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

      context 'given valid credentials' do

        let(:response) { Typhoeus::Response.new(
          :code => 200,
          :body => "{\"instance_url\":\"a\",\"access_token\":\"b\"}")
        }
        before :each do
          configuration.stub(:ask_salesforce).and_return(response)
        end

        it 'returns access token' do
          configuration.send(:request_credentials).should include('access_token')
        end

        it 'returns instance url' do
          configuration.send(:request_credentials).should include('instance_url')
        end

      end

      context 'given invalid credentials' do

        let(:response) { Typhoeus::Response.new(
          :code => 400,
          :body => "{\"error\":\"invalid_grant\",\"error_description\":"+
            "\"authentication failure - Failed: API security token required\"}"
        )}

        before :each do
          configuration.stub(:ask_salesforce).and_return(response)
        end

        it 'fails' do
          expect { configuration.send(:request_credentials) }.to raise_error(Salesforce::SalesforceError)
        end

      end

    end

  end

end

