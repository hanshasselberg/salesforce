require 'spec_helper'

describe 'Salesforce' do

  before :all do
    Salesforce.instance_variable_set(
      :@api_versions,
      [
        {"label"=>"Winter '12", "url"=>"/services/data/v23.0", "version"=>"23.0"},
        {"label"=>"Summer '11", "url"=>"/services/data/v22.0", "version"=>"22.0"}
      ]
    )
  end

  let(:version) { Salesforce.latest_api_version }
  let(:versions) { Salesforce.api_versions }

  describe ".latest_api_version" do

    specify { version.should include('url', 'version', 'label') }

    specify { version['version'].should == '23.0' }

  end

  describe '.api_versions' do

    specify { versions.should be_a(Array) }

  end

  describe ".configure" do

    context "when no block is supplied" do

      it "retuns configuration object" do
        Salesforce.configure.should === Salesforce.configuration
      end

    end

    context "when block is supplied" do

      it "sets configuration values" do
        Salesforce.configure do |config|
          config.username = 'test@test.de'
        end
        Salesforce.configuration.username.should eq('test@test.de')
      end

    end

  end

end
