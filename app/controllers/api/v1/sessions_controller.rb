# app/controllers/api/v1/sessions_controller.rb
class Api::V1::SessionsController < Api::V1::BaseController
  # Skip authentication for login (create action)
  skip_before_action :authenticate_user!, only: [:create]
  
  def create
    user = User.find_by(email: login_params[:email])
    
    if user&.valid_password?(login_params[:password])
      token = generate_jwt_token(user)
      response.headers['Authorization'] = "Bearer #{token}"
      
      render json: {
        status: 'success',
        message: 'Login successful',
        data: {
          user: {
            id: user.id,
            email: user.email,
            role: user.role
          },
          token: token
        }
      }, status: :ok
    else
      render json: {
        status: 'error',
        message: 'Invalid email or password'
      }, status: :unauthorized
    end
  end

  def destroy
    render json: {
      status: 'success',
      message: 'Logged out successfully'
    }, status: :ok
  end

  private

  def login_params
    params.require(:user).permit(:email, :password)
  end
end