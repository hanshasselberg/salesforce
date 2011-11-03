require 'spec_helper'

describe Salesforce::Serialization do

  let(:klass) { Account }
  let(:account) { klass.new }
  let(:json) { "{\"account\":{\"Id\":\"123\",\"Website\":\"www.example.com\"}}" }

  context 'given field Id and Website' do

    before do
      klass.field('Id'); klass.field('Website')
      account.id = '123'
      account.website = 'www.example.com'
    end

    describe '#to_json' do

      it 'returns proper json' do
        account.to_json.should eq(json)
      end

    end

    describe '#serializable_hash' do

      it 'returns hash with keys: Id and CreatedById' do
        account.serializable_hash.should include('Id', 'Website')
      end

    end

  end

end
