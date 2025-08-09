# # app/controllers/api/v1/base_controller.rb
# class Api::V1::BaseController < ActionController::API
#   before_action :authenticate_user!
  
#   private
  
#   def authenticate_user!
#     unless user_signed_in?
#       render json: { error: 'You are unauthorized' }, status: :unauthorized
#     end
#   end
# end
# # app/controllers/api/v1/base_controller.rb
# class Api::V1::BaseController < ActionController::API
#   before_action :authenticate_user!, except: [:create, :destroy]
  
#   private
  
#   def authenticate_user!
#     token = extract_token
    
#     if token
#       begin
#         decoded_token = JWT.decode(token, Rails.application.credentials.secret_key_base, true, algorithm: 'HS256')
#         user_id = decoded_token[0]['sub']
#         @current_user = User.find(user_id)
#       rescue JWT::DecodeError, ActiveRecord::RecordNotFound => e
#         render json: { error: 'Invalid or expired token' }, status: :unauthorized
#       end
#     else
#       render json: { error: 'Missing authorization token' }, status: :unauthorized
#     end
#   end
  
#   def extract_token
#     request.headers['Authorization']&.split(' ')&.last
#   end
  
#   def current_user
#     @current_user
#   end
  
#   def generate_jwt_token(user)
#     JWT.encode(
#       { 
#         sub: user.id, 
#         exp: 2.hours.from_now.to_i,
#         iat: Time.current.to_i
#       }, 
#       Rails.application.credentials.secret_key_base,
#       'HS256'
#     )
#   end
# end
# app/controllers/api/v1/base_controller.rb
class Api::V1::BaseController < ActionController::API
  before_action :authenticate_user!, except: [:create, :destroy]
  
  private
  
  def authenticate_user!
    token = extract_token
    
    if token
      begin
        decoded_token = JWT.decode(token, Rails.application.credentials.secret_key_base, true, algorithm: 'HS256')
        user_id = decoded_token[0]['sub']
        @current_user = User.find(user_id)
        
        # Debug logging
        Rails.logger.info "JWT decoded successfully. User ID: #{user_id}, User: #{@current_user&.email}"
        
      rescue JWT::DecodeError => e
        Rails.logger.error "JWT decode error: #{e.message}"
        render json: { error: 'Invalid JWT token' }, status: :unauthorized and return
      rescue ActiveRecord::RecordNotFound => e
        Rails.logger.error "User not found: #{e.message}"
        render json: { error: 'User not found' }, status: :unauthorized and return
      end
    else
      Rails.logger.error "No authorization token provided"
      render json: { error: 'Missing authorization token' }, status: :unauthorized and return
    end
  end
  
  def extract_token
    request.headers['Authorization']&.split(' ')&.last
  end
  
  def current_user
    @current_user
  end
  
  def generate_jwt_token(user)
    JWT.encode(
      { 
        sub: user.id, 
        exp: 2.hours.from_now.to_i,
        iat: Time.current.to_i
      }, 
      Rails.application.credentials.secret_key_base,
      'HS256'
    )
  end
end