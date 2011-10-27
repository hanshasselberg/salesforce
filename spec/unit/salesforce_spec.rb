require 'spec_helper'

describe 'Salesforce' do

  describe ".configure" do

    context "when no block is supplied" do

      it "retuns configuration object" do
        Salesforce.configure.should === Salesforce::Configuration
      end
    end

  end
end
