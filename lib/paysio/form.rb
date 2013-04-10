module Paysio
  class Form
    attr_accessor :params, :values, :errors, :html_options

    def initialize(params = {})
      @params = params
      @values = {}
      @errors = {}
      @html_options = {}
    end

    def add_params(params = {})
      self.params.merge!(params)
    end

    def render
      "#{render_html} #{render_javascript}".html_safe
    end

    def render_javascript
      html = <<-TEXT
        <script type="text/javascript">
          Paysio.setEndpoint('#{Paysio.api_url}');
          Paysio.setPublishableKey("#{Paysio.publishable_key}");
          Paysio.form.build(#{javascript_form_params});
        </script>
      TEXT
    end

    def render_html
      html = <<-TEXT
        <form id="#{html_options[:id] || 'paysio'}"
              class="#{html_options[:class]}"
              action="#{html_options[:action] || '#'}"
              method="#{(html_options[:method] || 'post').upcase}"
        ></form>
      TEXT
    end

    private
      def javascript_form_params
        params_html = "$('##{html_options[:id] || 'paysio'}'), #{params.to_json}, #{values.to_json}"
        params_html << ", #{errors.to_json}" if errors.present?
        params_html
      end
  end
end