class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  
  allow_browser versions: :modern
  before_action :set_local
  before_action :configure_premittted_parameters,if: :devise_controller?
  private
  def user_not_authorized
    flash[:alert] = "Your are not authorized to perform this action"
    redirect_to (request.referrer || root_path)
  end
  
  
  protected
  def configure_premittted_parameters
    devise_parameter_sanitizer.permit(:account_update,keys:[:password,:password_confirmation,:current_password])
    
  end
  # before_action :configure_permitted_parameters,if: :devise_controller?
  
    def set_local
      I18n.locale= :en
    end
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
