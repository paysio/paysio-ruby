module Paysio
  class List < Paysio::Resource
    include Paysio::Actions::List
    include Paysio::Actions::Find
    resource :list

    def each(&blk)
      self.data.each(&blk)
    end

    def first
      self.data.first
    end

    def last
      self.data.last
    end
  end
end