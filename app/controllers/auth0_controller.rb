class Auth0Controller < ApplicationController
  def callback
    reset_session
    auth_info = request.env['omniauth.auth']
    uid = auth_info['uid']
    expires_at = auth_info['credentials']['expires_at']

    session[WebAuth::USER_SESSION_KEY] = { uid:, expires_at: }

    if !User.find_by_uid(uid)
      User.new(uid:).save!
    end

    # Redirect to the URL you want after successful auth
    redirect_to '/dashboard'
  end

  def failure
    # Handles failed authentication -- Show a failure page (you can also handle with a redirect)
    @error_msg = request.params['message']
  end

  def logout
    reset_session
    redirect_to logout_url
  end

  private

  def logout_url
    config = Auth0Config.load
    request_params = {
      returnTo: root_url,
      client_id: config.web_client_id
    }

    URI::HTTPS.build(host: config.web_domain, path: '/v2/logout', query: request_params.to_query).to_s
  end
end
