require 'spec_helper'

describe 'Salesforce' do

  describe ".configure" do

    context "when no block is supplied" do

      it "retuns configuration object" do
        Salesforce.configure.should === Salesforce.configuration
      end

    end

    context "when block is supplied" do

      it "sets configuration values" do
        Salesforce.configure do |config|
          config.user = 'test@test.de'
        end
        Salesforce.configuration.user.should eq('test@test.de')
      end

    end

  end
end
