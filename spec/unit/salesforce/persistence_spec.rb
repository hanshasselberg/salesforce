require 'spec_helper'

describe Salesforce::Persistence do

  describe '.find' do

    let(:id) { '001U0000005cy3y' }
    let(:account) { Account.find(id) }

    context 'given a valid id' do

      it 'finds a sobject' do
        if ENV['SF_USERNAME']
          account.should be_a(Account)
        else
          pending 'ENV credentials missing.'
        end
      end

      it 'finds a sobject with correct id' do
        if ENV['SF_USERNAME']
          account.id.should == id
        else
          pending 'ENV credentials missing.'
        end
      end

    end

  end

end
