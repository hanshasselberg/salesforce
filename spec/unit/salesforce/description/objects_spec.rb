require 'spec_helper'
require 'account'

describe Salesforce::Description::Objects do

  describe '.objects' do

    let(:klass) do
      Account.instance_variable_set(
        :@objects_description,
        Account.send(:default_objects_description)
      )
      Account
    end

    specify { klass.objects_description.should be_a(Hash) }

  end
end
