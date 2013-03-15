module Paysio
  module Actions
    module Create
      module ClassMethods
        def create(attrs = {})
          response = Paysio::Client.request(:post, path, attrs)
          response["error"].blank? ? Resource.build_from(response) : response
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end