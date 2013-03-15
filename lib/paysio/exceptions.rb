module Paysio
  module Exceptions
    class NotAuthorized < Exception; end;
    class APIError < Exception; end;
  end
end