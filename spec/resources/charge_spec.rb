require 'spec_helper'
describe Paysio::Charge do
  it { should be_listable_resource }
  it { should be_updatable_resource }

  it "should return charge on create" do
    client = authorized_paysio_client

    client.expects(:post).once.returns(test_response(test_charge))
    c = Paysio::Charge.create
    c.should be_a_kind_of(Paysio::Charge)
  end
end