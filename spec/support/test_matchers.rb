RSpec::Matchers.define :be_listable_resource do |expected|
  match do |actual|
    client = authorized_paysio_client
    subject = actual.class
    test_response_hash = send(:"test_#{subject.name.demodulize.underscore}_array")

    client.expects(:get).once.returns(test_response(test_response_hash))
    c = subject.all.data

    c.should be_a_kind_of(Array)
    c[0].should be_a_kind_of(subject)
  end
end
RSpec::Matchers.define :be_updatable_resource do |expected|
  match do |actual|
    client = authorized_paysio_client
    subject = actual.class

    client.expects(:get).once.returns(test_response(test_customer({name: "foo"})))
    client.expects(:put).once.returns(test_response(test_customer({name: "bar"})))
    c = subject.retrieve("resource_id")
    c.name.should == "foo"
    c.name = "bar"
    c.save
    c.name.should == "bar"
  end
end
RSpec::Matchers.define :be_deleteable_resource do |expected|
  match do |actual|
    client = authorized_paysio_client
    subject = actual.class

    client.expects(:get).once.returns(test_response(test_customer({name: "foo"})))
    client.expects(:delete).once.returns(test_response(test_customer({name: "bar"})))
    c = subject.retrieve("resource_id")
    c.delete
  end
end