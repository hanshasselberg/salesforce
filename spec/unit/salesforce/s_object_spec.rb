require 'spec_helper'

describe Salesforce::SObject do

  describe '#initialize' do

    context 'given salesforce like hash' do

      let(:attributes) do
        {
          "attributes"=>{
            "type"=>"Account",
            "url"=>"/services/data/v22.0/sobjects/Account/001U0000005cy3yIAA"
        },
          "Id"=>"001U0000005cy3yIAA", "Name"=>"Test1",
          "CreatedDate"=>"2011-10-27T14:45:41.000+0000"
        }
      end
      let(:account) { Account.new(attributes) }

      before do
        Account.field(:name)
        Account.field(:id)
        Account.field(:created_date)
      end

      it 'sets id' do
        account.id.should == attributes['Id']
      end

      it 'sets name' do
        account.name.should == attributes['Name']
      end

      it 'sets created_date' do
        account.created_date.should == attributes['CreatedDate']
      end

    end

  end

  describe '.type' do

    specify { Account.type.should == 'Account'}

  end

end
