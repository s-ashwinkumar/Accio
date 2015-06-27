class ApplicationController < ActionController::Base
  protect_from_forgery
  def after_sign_in_path_for(resource)
  	session[:user_id] = resource.id
    session["resource_return_to"] = redirect_user
  end

  def redirect_user
    current_user.is_a?(Provider) ? "/user" : "/admin"
  end
end
