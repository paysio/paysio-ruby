require 'active_model/dirty'
module Paysio
  class Resource
    include ActiveModel::Dirty

    attr_accessor :redirect

    def initialize(values = {})
      @values = {}
      @id = values['id'] if values['id']
      refresh_from(values)
      self.class.define_attribute_methods(attributes.keys)
    end

    def refresh_from(values)
      values.each do |key, value|
        @values[key] = Resource.build_from(value)
      end
    end

    def to_s(*opts)
      Paysio::JSON.encode(@values)
    end

    def inspect
      id_string = !@id.nil? ? " id=#{@id}" : ""
      "#<#{self.class}:0x#{self.object_id.to_s(16)}#{id_string}> JSON: " + Paysio::JSON.encode(@values)
    end

    def method_missing(name, *opts)
      if name[-1] == '='
        name = name.to_s.gsub(/\=$/, '')
        send(:"#{name}_will_change!")
        @values[name.to_s] = opts.first if @values.has_key?(name.to_s)
      else
        @values[name.to_s] if @values.has_key?(name.to_s)
      end
    end

    def to_json(*opts)
      Paysio::JSON.encode(@values)
    end

    def as_json(*opts)
      @values.as_json(*a)
    end

    def to_hash
      @values
    end

    def attributes
      to_hash.reject{ |k, v| v.is_a? (Paysio::Resource)}
    end

    def attribute(key)
      to_hash[key]
    end

    def each(&blk)
      @values.each(&blk)
    end

    def path
      "#{self.class.path}/#{@id}"
    end

    def action_path(action)
      "#{path}/#{action}"
    end

    class << self
      def resource(resource_name)
        @@registered_resources ||= []
        @@registered_resources << resource_name.to_s
      end

      def path
        "/#{self.name.demodulize.tableize}"
      end

      def build_from(resp, redirect_url = nil)
        case resp
        when Array
          resp.map { |values| build_from(values) }
        when Hash
          if @@registered_resources && @@registered_resources.include?(resp['object'])
            klass = "Paysio::#{resp['object'].classify}".constantize
          else
            klass = Paysio::Resource
          end
          resource = klass.new(resp)
          resource.redirect = redirect_url
          resource
        else
          resp
        end
      end
    end
  end
end