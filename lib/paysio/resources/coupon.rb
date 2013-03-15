module Paysio
  class Coupon < Paysio::Resource
    include Paysio::Actions::List
    include Paysio::Actions::Create
    include Paysio::Actions::Update
    include Paysio::Actions::Destroy
    include Paysio::Actions::Find
    resource :coupon
  end
end