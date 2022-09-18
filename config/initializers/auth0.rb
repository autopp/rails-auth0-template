Rails.application.config.middleware.use OmniAuth::Builder do
  config = Auth0Config.load
  provider(
    :auth0,
    config.web_client_id,
    config.web_client_secret,
    config.web_domain,
    callback_path: '/auth/auth0/callback',
    authorize_params: {
      scope: 'openid profile'
    }
  )
end
