module Paysio
  class Event < Paysio::Resource
    include Paysio::Actions::List
    include Paysio::Actions::Find
    resource :event
  end
end