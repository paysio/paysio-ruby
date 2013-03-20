module Paysio
  class Coupon < Paysio::Resource
    include Paysio::Actions::List
    include Paysio::Actions::Create
    include Paysio::Actions::Update
    include Paysio::Actions::Destroy
    include Paysio::Actions::Find
    resource :coupon

    def self.check(code)
      response = Paysio::Client.request(:get, "#{self.path}/code/#{code}/check")
      Resource.build_from(response)
    end
  end
end