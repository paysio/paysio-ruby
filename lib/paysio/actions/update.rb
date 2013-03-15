module Paysio
  module Actions
    module Update
      def update(attrs = {})
        response = Paysio::Client.request(:put, path, attrs)
        response["error"].blank? ? refresh_from(response.to_hash) : response
      end

      def save
        @previously_changed = changes
        @changed_attributes.clear
        update(changed_attributes)
      end
    end
  end
end