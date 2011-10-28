require 'spec_helper'

describe Salesforce::SObject do

  let(:klass) { Account }

  describe '.where' do

    context 'give a valid id' do

      it 'returns finds an object' do
        klass.where(:id => '123').should_not be_empty
      end

    end

  end

end
