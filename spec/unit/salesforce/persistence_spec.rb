require 'spec_helper'

describe Salesforce::Persistence do

  let(:klass) { Account }

  # describe '#save' do

  #   context 'given a new object' do

  #     it 'returns object' do
  #       pending
  #       klass.new(:name => 'Test').save.should be_a(klass)
  #     end

  #     it 'writes valid id' do
  #       pending
  #       klass.new(:name => 'Test').save.id.should be
  #     end

  #   end

  # end

  describe '.find' do

    let(:id) { '001U0000005cy3yIAA' }
    let(:klass) { Account }
    let(:account) { klass.find(id) }

    before :all do
      Account.field('Id')
      hydra = Typhoeus::Hydra.hydra
      response = Typhoeus::Response.new(
        :code => 200, :headers => "",
        :body => '{ "Id": "123"}', :time => 0.3
      )
      hydra.stub(
        :get,
        Salesforce::Description::Objects.object_url(
          klass.ressource_name, id
        )
      ).and_return(response)
    end

    context 'given a valid id' do

      subject { account }

      it 'finds a sobject' do
        should be_a(klass)
      end

      it 'finds a sobject with correct id' do
        id.should == id
      end

    end

  end

end
