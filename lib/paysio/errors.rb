module Paysio
  module Errors
    class Unauthorized < Exception; end;
    class InternalError < Exception; end;
    class Forbidden < Exception; end;
    class BadRequest < Exception; end;
    class NotFound < Exception; end;
  end
end