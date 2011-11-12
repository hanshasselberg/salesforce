require 'spec_helper'

describe Salesforce::Description::ApiVersions do

  let(:mod) do
    Salesforce::Description::ApiVersions
  end

  let(:version) { mod.latest }


  describe ".latest" do

    specify { version.should include('url', 'version', 'label') }

    specify { version['version'].should == '23.0' }

  end

end
