module Paysio
  module Actions
    module Find
      module ClassMethods
        def find(id)
          response = Paysio::Client.request(:get, "#{path}/#{id}")
          Resource.build_from(response)
        end
        alias_method :retrieve, :find
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end