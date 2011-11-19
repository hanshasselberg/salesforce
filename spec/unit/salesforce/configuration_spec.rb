require 'spec_helper'

describe Salesforce::Configuration do

  let(:configuration) { Salesforce::Configuration.new }
  before(:each){ configuration.reset }

  describe '#reset' do

    it 'removes previous cached response' do
      configuration.instance_variable_set(:@response, true)
      configuration.reset
      configuration.instance_variable_get(:@response).should == nil
    end

  end

  describe '#service_path' do

    specify { configuration.service_path.should be_a(String) }

  end

  context 'salesforce interaction' do

    describe '#ask_salesforce' do

      context 'given valid credentials' do

        before do
          hydra = Typhoeus::Hydra.hydra
          response = Typhoeus::Response.new(
            :code => 200, :headers => "",
            :body => '{ "access_token": "123", "instance_url":"fubar"}',
            :time => 0.3
          )
          hydra.stub(
            :post,
            Salesforce.configuration.access_token_url
          ).and_return(response)
        end

        specify do
          configuration.send(:ask_salesforce).should be_a(Typhoeus::Response)
        end

      end

    end

  end

end

