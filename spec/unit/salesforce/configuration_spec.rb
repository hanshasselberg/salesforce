require 'spec_helper'
require 'account'
require 'opportunity'

describe Salesforce::Configuration do

  let(:configuration) { Salesforce::Configuration.new }
  before(:each){ configuration.reset }

  describe '.reset' do

    it 'removes previous cached response' do
      configuration.instance_variable_set(:@response, true)
      configuration.reset
      configuration.instance_variable_get(:@response).should == nil
    end

  end

  context 'salesforce interaction' do

    describe '.ask_salesforce' do

      context 'given valid credentials' do

        specify do
          if ENV['SF_USERNAME']
            configuration.send(:ask_salesforce).should be_a(Typhoeus::Response)
          else
            pending 'ENV credentials missing.'
          end
        end

      end

      context 'given invalid credentials' do

        it 'fails' do
          configuration.instance_variable_set(:@client_secret, '1234')
          expect { configuration.send(:ask_salesforce) }.to raise_error(Salesforce::SalesforceError)
        end

      end

    end

  end

end

