 module Paysio::TestResponses
  def test_response(body, code = 200, location = 'test')
    body = Paysio::JSON.encode(body) if !(body.kind_of? String)
    m = mock
    m.instance_variable_set('@data', { body: body, code: code , location: location})
    def m.body; @data[:body]; end
    def m.code; @data[:code]; end
    def m.headers; {location: @data[:location]} end
    m
  end

  def test_customer(params={})
    {
      :object => 'customer',
      :merchant_id => 'm_12345',
      :email => 'user@example.com',
      :phone_number => '+71234567',
      :name => 'Bruce Lee',
      :description => 'Foo bar',
      :created => '1345537759',
      :livemode => false
    }.merge(params)
  end

  def test_customer_array
    {
      :data => [test_customer, test_customer, test_customer],
      :object => 'list'
    }
  end

  def test_charge(params={})
    {
      :object => 'charge',
      :id => "ch_BFyI4KoDVHzsfNoXpi4",
      :merchant_id => 'm_12345',
      :amount => 100,
      :fee => 10,
      :status => 'pending',
      :order_id => 'o_1234234',
      :return_url => 'http://example.com',
      :livemode => false
    }.merge(params)
  end

  def test_charge_array
    {
      :data => [test_charge, test_charge, test_charge],
      :object => 'list'
    }
  end

  def test_coupon(params={})
    {
      :object => 'coupon',
      :merchant_id => 'm_12345',
      :percent_off => 30,
      :currency_id => 'usd',
      :code => 'foo',
      :livemode => false
    }.merge(params)
  end

  def test_coupon_array
    {
      :data => [test_coupon, test_coupon, test_coupon],
      :object => 'list'
    }
  end

  def test_event(params={})
    {
      :object => 'event',
      :merchant_id => 'm_12345',
      :type => 'charge.create',
      :livemode => false
    }.merge(params)
  end

  def test_event_array
    {
      :data => [test_event, test_event, test_event],
      :object => 'list'
    }
  end

  def test_log(params={})
    {
      :object => 'log',
      :request_url => 'http://example.com',
      :request_ip => '127.0.0.1',
      :request_post_params  => {
        :email => "test@test.ru",
        :description => "Test customer"
      },
      :livemode => false
    }.merge(params)
  end

  def test_log_array
    {
      :data => [test_log, test_log, test_log],
      :object => 'list'
    }
  end

  def test_wallet(params={})
    {
      :object => 'wallet',
      :merchant_id => 'm_12345',
      :type => 'test',
      :account => 'foo',
      :account_number => '12345',
      :account_id => 'ac_12345',
      :livemode => false
    }.merge(params)
  end

  def test_wallet_array
    {
      :data => [test_wallet, test_wallet, test_wallet],
      :object => 'list'
    }
  end

  def test_payout(params={})
    {
      :object => 'payout',
      :merchant_id => 'm_12345',
      :amount => 50,
      :status => 'success',
      :wallet => test_wallet,
      :livemode => false
    }.merge(params)
  end

  def test_payout_array
    {
      :data => [test_payout, test_payout, test_payout],
      :object => 'list'
    }
  end

  def test_reward(params={})
    {
      :object => 'reward',
      :merchant_id => 'm_12345',
      :title => 'Foo Bar',
      :percent_off => 50,
      :max_amount => 100,
      :livemode => false
    }.merge(params)
  end

  def test_reward_array
    {
      :data => [test_reward, test_reward, test_reward],
      :object => 'list'
    }
  end
end