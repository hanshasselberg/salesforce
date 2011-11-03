require 'spec_helper'

describe Salesforce::Serialization do

  let(:klass) { Account }
  let(:account) { klass.new }

  describe '#serializable_hash' do

    context 'given field Id and Website' do

      before do
        klass.field('Id'); klass.field('Website')
        account.id = '123'
        account.website = 'www.example.com'
      end

      it 'returns hash with keys: Id and CreatedById' do
        account.serializable_hash.should include('Id', 'Website')
      end

    end

  end

end
