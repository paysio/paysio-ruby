module Paysio
  module Actions
    module List
      module ClassMethods
        def all
          response = Paysio::Client.request(:get, path)
          Resource.build_from(response)
        end

        def count
          all.count
        end

        def first
          all.first
        end

        def last
          all.last
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end