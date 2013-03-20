require 'spec_helper'
describe Paysio::Coupon do
  it { should be_listable_resource }
  it { should be_updatable_resource }
  it { should be_deleteable_resource }

  it "should return coupon on create" do
    client = authorized_paysio_client

    client.expects(:post).once.returns(test_response(test_coupon))
    c = Paysio::Coupon.create
    c.should be_a_kind_of(Paysio::Coupon)
  end

  it "should return coupon while checking code" do
    client = authorized_paysio_client

    client.expects(:get).once.returns(test_response(test_coupon))
    c = Paysio::Coupon.check('test_code')
    c.should be_a_kind_of(Paysio::Coupon)
  end
end