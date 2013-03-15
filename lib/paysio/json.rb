module Paysio
  class JSON
    class << self
      def decode(text)
        Oj.load(text)
      end

      def encode(json)
        Oj.dump(json, mode: :compat)
      end
    end
  end
end