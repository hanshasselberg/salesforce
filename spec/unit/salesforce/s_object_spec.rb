require 'spec_helper'

describe Salesforce::SObject do

  let(:klass) { Account }

  describe '.where' do

    context 'give a valid id' do

      it 'finds an object' do
        klass.where(:id => '123').should include(klass)
      end

    end

  end

end
