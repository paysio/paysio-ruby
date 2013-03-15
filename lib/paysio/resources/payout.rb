module Paysio
  class Payout < Paysio::Resource
    include Paysio::Actions::List
    include Paysio::Actions::Create
    include Paysio::Actions::Find
    resource :payout
  end
end