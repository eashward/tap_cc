module ApiClient
  class CampaignsClient < Base
    SERVICE_URI = 'https://staging.tapresearch.com'
    BASE_URI = 'api/v1/campaigns'

    def initialize
      auth = 'Basic ' + Base64.strict_encode64("#{user_name}:#{api_token}")
      super(service_uri: SERVICE_URI, headers: { 'Authorization' => auth })
    end

    def all
      res = connection.get(BASE_URI)
      res = handle_response(response: res)
      Rails.logger.info "###### #{res.count} campaigns fetched from remote ########"
      res
    end

    def find(id:)
      uri = BASE_URI + '/' + id.to_s
      res = connection.get(uri)
      handle_response(response: res)
    end

    def user_name
      Rails.application.credentials.config[:user_name]
    end

    def api_token
      Rails.application.credentials.config[:api_token]
    end
  end
end
