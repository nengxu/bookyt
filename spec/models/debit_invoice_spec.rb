require 'spec_helper'

describe DebitInvoice do
  describe "as class" do
    subject {DebitInvoice}

    context "without the accounts" do
      its(:direct_account) {should be_nil}
      its(:available_debit_accounts) {should be_empty}
      its(:default_debit_account) {should be_nil}
      its(:available_credit_accounts) {should be_empty}
      its(:default_credit_account) {should be_nil}
    end

    context "with correct accounts loaded" do
      before(:all) do
        [:debit_account, :credit_account, :service_account].each do |name|
          Factory.create(name)
        end
      end

      its(:direct_account) {should == Account.find_by_code('1100')}
      its(:available_debit_accounts) {should_not be_empty}
      its(:default_debit_account) {should == Account.find_by_code('3200')}
      its(:available_credit_accounts) {should_not be_empty}
      its(:default_credit_account) {should == Account.find_by_code('1100')}
    end
  end

  describe "as an instance" do
    subject { Factory.create(:debit_invoice, :due_date => Date.yesterday,
                                             :value_date => Date.yesterday) }

    context "without bookings" do
      its(:balance_account) { should be_nil }
      its(:profit_account) { should be_nil }
    end
  end
end
