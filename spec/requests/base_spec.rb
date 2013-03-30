require 'spec_helper'
require 'rest_client'
require 'ostruct'
describe "API Bindings" do

  before :all do
    @client = authorized_paysio_client
  end

  it "should not fetch from network while creating a new Resource" do
    @client.expects(:get).never
    Paysio::Charge.new(id: "someid")
  end

  it "should add redirect url to resource from location" do
    @client.expects(:get).once.returns(test_response(test_charge, 200, 'http://example.com'))
    Paysio::Charge.retrieve("someid").redirect == 'http://example.com'
  end

  describe "exception handler" do

    before :all do
      @client = Paysio::Client
    end

    it "should raise Paysio::Errors::BadRequest on 400" do
      exception = RestClient::Exception.new(OpenStruct.new(code: 400, body: 'message'))
      RestClient::Request.stubs(:execute).raises(exception)
      expect { @client.execute!({}) }.to raise_error(Paysio::Errors::BadRequest)
    end

    it "should raise Paysio::Errors::Unauthorized on 401" do
      exception = RestClient::Exception.new(OpenStruct.new(code: 401, body: 'message'))
      RestClient::Request.stubs(:execute).raises(exception)
      expect { @client.execute!({}) }.to raise_error(Paysio::Errors::Unauthorized)
    end

    it "should raise Paysio::Errors::Forbidden on 403" do
      exception = RestClient::Exception.new(OpenStruct.new(code: 403, body: 'message'))
      RestClient::Request.stubs(:execute).raises(exception)
      expect { @client.execute!({}) }.to raise_error(Paysio::Errors::Forbidden)
    end

    it "should raise Paysio::Errors::NotFound on 404" do
      exception = RestClient::Exception.new(OpenStruct.new(code: 404, body: 'message'))
      RestClient::Request.stubs(:execute).raises(exception)
      expect { @client.execute!({}) }.to raise_error(Paysio::Errors::NotFound)
    end

    it "should raise Paysio::Errors::InternalError on 500" do
      exception = RestClient::Exception.new(OpenStruct.new(code: 500, body: 'message'))
      RestClient::Request.stubs(:execute).raises(exception)
      expect { @client.execute!({}) }.to raise_error(Paysio::Errors::InternalError)
    end

    it "should raise Paysio::Errors::Unauthorized if api_key is not provided" do
      Paysio.api_key = nil
      RestClient::Request.stubs(:execute).returns('test')
      expect { @client.request('get', 'test') }.to raise_error(Paysio::Errors::Unauthorized)
    end
  end
end