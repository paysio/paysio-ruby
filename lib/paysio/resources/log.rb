module Paysio
  class Log < Paysio::Resource
    include Paysio::Actions::List
    include Paysio::Actions::Find
    resource :log
  end
end