require 'spec_helper'
describe Paysio::Log do
  it { should be_listable_resource }

  it "should have request post params" do
    client = authorized_paysio_client

    client.expects(:get).once.returns(test_response(test_log))
    c = Paysio::Log.retrieve('someid')
    c.request_post_params.should_not be_blank
  end
end