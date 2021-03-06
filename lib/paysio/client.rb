module Paysio
  class Client
    class << self
      def request(method, path, params = {}, headers = {})
        unless Paysio.api_key
          raise Paysio::Errors::Unauthorized, "Please specify Paysio.api_key"
        end
        headers = {
          :user_agent => "Pays.io RubyClient/#{Paysio::VERSION}",
          :content_type => 'application/x-www-form-urlencoded'
        }.merge(headers)
        opts = {
          :url => Paysio.api_url(path),
          :method => method,
          :timeout => 80,
          :headers => headers
        }

        # build params
        case method.to_s.downcase.to_sym
        when :get, :head, :delete
          opts[:url] += "?#{stringify_params(params)}" if params.count > 0
        else
          opts[:payload] = stringify_params(params)
        end
        response = execute(opts)
        body, code = response.body, response.code
        begin
          resp = Paysio::JSON.decode(body)
        rescue Oj::ParseError
          raise Paysio::Exceptions::InternalError.new("Invalid response object from API: #{body.inspect} (#{code})", code, body)
        end
        Paysio::Resource.build_from(resp, response.headers[:location])
      end

      def execute(opts)
        RestClient::Request.execute(opts)
      rescue RuntimeError => e
        case e.http_code.to_i
        when 400
          raise Paysio::Errors::BadRequest, e.http_body
        when 401
          raise Paysio::Errors::Unauthorized, e.http_body
        when 403
          raise Paysio::Errors::Forbidden, e.http_body
        when 404
          raise Paysio::Errors::NotFound, e.http_body
        when 500
          raise Paysio::Errors::InternalError, e.http_body
        else
          raise e
        end
      end

      def uri_escape(key)
        URI.escape(key.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
      end

      def flatten_params(params, parent_key = nil)
        result = []
        params.each do |key, value|
          flatten_key = parent_key ? "#{parent_key}[#{uri_escape(key)}]" : uri_escape(key)
          result += value.is_a?(Hash) ? flatten_params(value, flatten_key) : [[flatten_key, value]]
        end
        result
      end

      def stringify_params(params)
        flatten_params(params).collect{|key, value| "#{key}=#{uri_escape(value)}"}.join('&')
      end
    end
  end
end