class SessionsController < ApplicationController

  def create
    facebook_request = env["omniauth.auth"]
    user_name = facebook_request["info"]["name"]
    user_email = facebook_request["info"]["email"]
    user_photo = facebook_request["info"]["image"]
    if User.find_by_email(user_email).nil?
      user = User.new
      user.email = user_email
      user.name = user_name
      user.photo = user_photo
      user.password = (0...16).map { (97 + rand(26)).chr }.join
      user.save
    else
      user = User.find_by_email(user_email)
    end
    sign_in user
    redirect_to orders_path
  end

end
