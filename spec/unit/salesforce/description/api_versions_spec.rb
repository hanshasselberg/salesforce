require 'spec_helper'

describe Salesforce::Description::ApiVersions do

  let(:klass) do
    class Dummy
      include Salesforce::Description::ApiVersions
    end
    Dummy
  end

  let(:version) { klass.api_version }


  describe ".api_version" do

    specify { version.should include('url', 'version', 'label') }

    specify { version['version'].should == '23.0' }

  end

end
