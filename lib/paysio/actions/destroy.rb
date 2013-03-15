module Paysio
  module Actions
    module Destroy
      def destroy(attrs = {})
        response = Paysio::Client.request(:delete, path)
        refresh_from(response.to_hash)
      end
    end
  end
end