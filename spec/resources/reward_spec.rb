require 'spec_helper'
describe Paysio::Reward do
  it { should be_listable_resource }
  it { should be_updatable_resource }

  it "should return reward on create" do
    client = authorized_paysio_client

    client.expects(:post).once.returns(test_response(test_reward))
    c = Paysio::Reward.create
    c.should be_a_kind_of(Paysio::Reward)
  end
end