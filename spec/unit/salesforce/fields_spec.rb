require 'spec_helper'

describe Salesforce::Fields do

  describe '.discovery' do

    let(:description) { {
      "name" => "Account",
      "fields" =>
      [
        {
          "length" => 18,
          "name" => "Id",
          "type" => "id",
          "defaultValue" => { "value" => null }
        }
      ]}
    }



  end
end
