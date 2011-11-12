require 'spec_helper'
require 'account'

describe Salesforce::Attributes do

  describe "#attributes" do

    specify { Account.new.should respond_to(:attributes) }

  end

  describe "#[]=" do

    let(:account) { Account.new }

    context "when setting the attribute to 1" do

      before { account[:name] = 1 }

      specify { account[:name].should == 1 }

    end

  end

end
