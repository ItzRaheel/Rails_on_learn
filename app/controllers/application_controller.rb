class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  # before_action :configure_permitted_parameters,if: :devise_controller?
  # def after_sign_in_path_for(resource)
  #   home_path
  # end
  # def after_sign_up_for(resource)
  #   home_path
  # end
  # protected
  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_in,keys:[:email,:password])
  # end



end
