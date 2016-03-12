class SessionsController < ApplicationController
  def twitter
    user = User.find_or_create_from_auth_hash(request.env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to '/top', notice: 'twitterログインしました'
  end

  def facebook
    user = User.find_or_create_from_auth_hash(request.env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to '/top', notice: 'facebookログインしました'
  end

  def destroy
      reset_session
      redirect_to root_path, notice: 'ログアウトしました'
    end
end
