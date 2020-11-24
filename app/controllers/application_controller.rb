class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_up_path_for(resource)
    posts_path
  end

  def after_sign_in_path_for(resource)
    if user_signed_in?
      user_path(current_user.id)
    else
      root_path
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end
end
