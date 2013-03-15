require 'spec_helper'
describe "API Bindings" do

  before :all do
    @client = authorized_paysio_client
  end

  it "should not fetch from network while creating a new Resource" do
    @client.expects(:get).never
    Paysio::Charge.new("someid")
  end

  it "should add redirect url to resource from location" do
    @client.expects(:get).once.returns(test_response(test_charge, 200, 'http://example.com'))
    Paysio::Charge.retrieve("someid").redirect == 'http://example.com'
  end
end