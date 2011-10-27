require 'spec_helper'

describe Salesforce::Connection do

  let(:connection) { Salesforce::Connection.new }

  describe '.reset' do

    it 'removes previous cached response' do
      connection.instance_variable_set(:@response, true)
      connection.reset
      connection.instance_variable_get(:@response).should eq(nil)
    end

  end

end

