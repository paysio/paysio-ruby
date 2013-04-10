module Paysio
  module Errors
    class Base < Exception
      alias_method :exception_body, :message
      def attributes
        @attributes ||= Paysio::JSON.decode(exception_body)['error']
      end

      def type
        attributes['type']
      end

      def message
        attributes['message']
      rescue
        exception_body
      end

      def params
        attributes['params']
      end
    end
    class Unauthorized < Base; end;
    class InternalError < Base; end;
    class Forbidden < Base; end;
    class BadRequest < Base; end;
    class NotFound < Base; end;
  end
end