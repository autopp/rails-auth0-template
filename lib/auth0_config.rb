class Auth0Config
  attr_reader :web_client_id, :web_client_secret, :web_domain, :api_audience

  def initialize(web_client_id:, web_client_secret:, web_domain:)
    @web_client_id = web_client_id
    @web_client_secret = web_client_secret
    @web_domain = web_domain
  end

  def self.load
    @config ||= new(
      web_client_id: ENV['AUTH0_WEB_CLIENT_ID'],
      web_client_secret: ENV['AUTH0_WEB_CLIENT_SECRET'],
      web_domain: ENV['AUTH0_WEB_DOMAIN'],
    )
  end
end
