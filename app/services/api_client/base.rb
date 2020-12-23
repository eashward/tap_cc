module ApiClient
  class Base
    attr_reader :service_uri, :headers, :parameters

    def initialize(service_uri:, headers: {})
      default_headers = { 'Content-Type' => 'application/json' }
      @service_uri = service_uri
      @headers = default_headers.merge!(headers)
    end

    def connection
      Faraday.new(url: service_uri, params: parameters, headers: headers) do |faraday|
        log_responses(faraday: faraday)
        faraday.adapter Faraday.default_adapter
      end
    end

    def log_responses(faraday:)
      faraday.response :logger, Rails.logger, bodies: true do |logger|
        logger.filter(/(authorization\s*:\s*)(?:"|')?(?:.*?)(?:'|")?.*/i, '\1[REMOVED]')
      end
    end

    def handle_response(response:)
      if success_response?(response)
        JSON.parse(response.body)
      else
        handle_error(response)
        nil
      end
    end

    def success_response?(response)
      status = response.status
      status >= 200 && status < 400
    end

    def handle_error(response)
      Rails.logger.error response.body.inspect
    end
  end
end
