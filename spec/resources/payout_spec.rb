require 'spec_helper'
describe Paysio::Payout do
  it { should be_listable_resource }

  it "should return payout on create" do
    client = authorized_paysio_client

    client.expects(:post).once.returns(test_response(test_payout))
    c = Paysio::Payout.create
    c.should be_a_kind_of(Paysio::Payout)
  end

  it "should have wallet" do
    client = authorized_paysio_client

    client.expects(:get).once.returns(test_response(test_payout))
    c = Paysio::Payout.retrieve('someid')
    c.wallet.should be_a_kind_of(Paysio::Wallet)
  end
end