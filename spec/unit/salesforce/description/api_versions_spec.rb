require 'spec_helper'

describe Salesforce::Description::ApiVersions do

  let(:klass) do
    class Dummy
      include Salesforce::Description::ApiVersions
    end
    Dummy
  end

  let(:version) { klass.latest_api_version }
  let(:versions) { klass.api_versions }

  context 'when discovery is turned off' do

    describe ".latest_api_version" do

      specify { version.should include('url', 'version', 'label') }

      specify { version['version'].should == '23.0' }

    end

    describe '.api_versions' do

      specify { versions.should be_a(Array) }

    end

  end

end
