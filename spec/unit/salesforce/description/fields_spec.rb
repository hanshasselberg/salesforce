require 'spec_helper'
require 'account'

describe Salesforce::Description::Fields do

  describe '.objects' do

    let(:klass) do
      Account.instance_variable_set(
        :@fields_description,
        Account => Account.send(:default_fields_description, Account))
      Account
    end

    specify { klass.fields_description(klass).should be_a(Array) }

  end
end
