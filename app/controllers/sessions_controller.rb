class SessionsController < ApplicationController

  def create
    auth = env["omniauth.auth"]
    @user = User.facebook_login(auth)
    sign_in @user
    redirect_to root_path
    flash[:success] = "Successfully logged in via Facebook!"
  end

end
