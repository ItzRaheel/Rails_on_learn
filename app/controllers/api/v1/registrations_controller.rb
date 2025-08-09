# app/controllers/api/v1/registrations_controller.rb
class Api::V1::RegistrationsController < Api::V1::BaseController
  # Skip authentication for signup (create action)
  skip_before_action :authenticate_user!, only: [:create]
  
  def create
    user = User.new(user_params)
    
    if user.save
      token = generate_jwt_token(user)
      response.headers['Authorization'] = "Bearer #{token}"
      
      render json: {
        status: 'success',
        message: 'User registered successfully',
        data: {
          user: {
            id: user.id,
            email: user.email,
            role: user.role
          },
          token: token
        }
      }, status: :created
    else
      render json: {
        status: 'error',
        message: 'User registration failed',
        errors: user.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end