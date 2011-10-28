require 'spec_helper'

describe Salesforce::SObject do

  let(:account) { Account.new }

  describe "#==" do

    context "when comparable is not a object" do

      let(:other) do
        "Object"
      end

      it "returns false" do
        account.should_not == other
      end
    end

    context "when comparable is a object" do

      context "when it has the same id" do

        context "when the classes are not the same" do

          let(:other) do
            Opportunity.new
          end

          before do
            other.id = account.id
          end

          it "returns false" do
            account.should_not == other
          end
        end

        context "when the classes are the same" do

          let(:other) do
            Person.new
          end

          before do
            other.id = account.id
          end

          it "returns true" do
            account.should == other
          end
        end
      end

      context "when it has a different id" do

        let(:other) do
          Person.new
        end

        context "when the instances are the same" do

          it "returns true" do
            account.should == account
          end
        end

        context "when the instances are different" do

          it "returns false" do
            account.should_not == other
          end
        end
      end
    end
  end
end
