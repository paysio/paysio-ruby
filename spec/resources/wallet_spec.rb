require 'spec_helper'
describe Paysio::Wallet do
  it { should be_listable_resource }
  it { should be_updatable_resource }
  it { should be_deleteable_resource }

  it "should return wallet on create" do
    client = authorized_paysio_client

    client.expects(:post).once.returns(test_response(test_wallet))
    c = Paysio::Wallet.create
    c.should be_a_kind_of(Paysio::Wallet)
  end
end