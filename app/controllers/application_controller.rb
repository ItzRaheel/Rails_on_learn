require 'pagy'
require 'pagy/extras/bootstrap'


class ApplicationController < ActionController::Base
    # protect_from_forgery with: :exception


     protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token, if: :json_request?
  
  protect_from_forgery with: :null_session # ✅
  
  #  skip_before_action :verify_authenticity_token
  include ActionController::MimeResponds
  respond_to :html ,:json
  # before_action :authenticate_user!
  
  # rescue_from ActionController::InvalidAuthenticityToken do
  #   render json: { error: 'Invalid or missing CSRF token' }, status: :unauthorized
  # end
  
  # def authenticate_user!
  #   unless user_signed_in?
  #     render json: { error: 'You are unauthorized' }, status: :unauthorized
  #   end
  # end

  include Pagy::Backend
  
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # before_action :authenticate_user!
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  respond_to :json
  allow_browser versions: :modern
  before_action :set_local
  before_action :configure_premittted_parameters,if: :devise_controller?
  private
  
  def json_request?
    request.format.json?
  end
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
# class ApplicationController < ActionController::Base
#   include Pundit

#   rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  
#   allow_browser versions: :modern
#   before_action :set_locale
#   before_action :configure_permitted_parameters, if: :devise_controller?
  
#   private
  
#   def user_not_authorized
#     flash[:alert] = "You are not authorized to perform this action"
#     redirect_to(request.referrer || root_path)
#   end
  
#   protected
  
#   def configure_permitted_parameters
#     devise_parameter_sanitizer.permit(:account_update, keys: [:password, :password_confirmation, :current_password])
#   end
  
#   def set_locale
#     I18n.locale = :en
#   end
# end