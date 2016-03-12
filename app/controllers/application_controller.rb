class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :logged_in?
    private

  def url
    current_url = request.url
    current_url = "http://localhost:3000/"
  end

  private

  def logged_in?
    !!session[:user_id]
  end

    private

  def current_user
    @_current_user ||= User.find_by(id: session[:user_id])
  end
end