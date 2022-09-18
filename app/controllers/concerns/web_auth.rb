module WebAuth
  extend ActiveSupport::Concern

  USER_SESSION_KEY = :user

  def authenticate_user!
    redirect_to '/' if !logged_in?
  end

  def logged_in?
    session[USER_SESSION_KEY].present? && session[USER_SESSION_KEY]['expires_at'] >= Time.current.to_i
  end

  def current_user
    auth = session[USER_SESSION_KEY] || {}
    @current_user ||= User.find_by_uid(auth['uid'])
  end
end
