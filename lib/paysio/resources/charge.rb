module Paysio
  class Charge < Paysio::Resource
    include Paysio::Actions::List
    include Paysio::Actions::Create
    include Paysio::Actions::Update
    include Paysio::Actions::Find
    resource :charge

    def refund(attrs = {})
      response = Paysio::Client.request(:post, action_path(:refund), attrs)
      refresh_from(response.to_hash)
    end

    def invoice
      response = Paysio::Client.request(:get, action_path(:invoice))
      Resource.build_from(response.to_hash)
    end
  end
end