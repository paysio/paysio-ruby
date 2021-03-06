module Paysio
  class Customer < Paysio::Resource
    include Paysio::Actions::List
    include Paysio::Actions::Create
    include Paysio::Actions::Update
    include Paysio::Actions::Destroy
    include Paysio::Actions::Find
    resource :customer
  end
end