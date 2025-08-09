# # # frozen_string_literal: true

# # class Users::SessionsController < Devise::SessionsController
# #   # before_action :configure_sign_in_params, only: [:create]
# # # after_action :check_condition

# # # def check_condition
# # #   redirect_to root_path
# # # end
# # #  def after_sign_in_path_for(resource)
# # #     home_path
# # #   end
# # #   def after_sign_up_for(resource)
# # #     home_path
# # #   end

# #   # GET /resource/sign_in
# #   # def new
# #   #   super
# #   # end

# #   # POST /resource/sign_in
# #   # def create
# #   #   super
# #   # end

# #   # DELETE /resource/sign_out
# #   # def destroy
# #   #   super
# #   # end

# #   # protected

# #   # If you have extra params to permit, append them to the sanitizer.
# #   # def configure_sign_in_params
# #   #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
# #   # end
# # end
# # app/controllers/users/sessions_controller.rb
# # class Users::SessionsController < Devise::SessionsController
# #   respond_to :json

# #   # Prevent rendering HTML login form
# #   def new
# #     render json: { error: "Login via POST /users/sign_in" }, status: :method_not_allowed
# #   end

# #   private

# #   def respond_with(resource, _opts = {})
# #     if resource.persisted?
# #       render json: { message: "Logged in successfully", user: resource }, status: :ok
# #     else
# #       render json: { error: "Invalid credentials" }, status: :unauthorized
# #     end
# #   end

# #   def respond_to_on_destroy
# #     render json: { message: "Logged out successfully" }, status: :ok
# #   end
# # end
# class Users::SessionsController < Devise::SessionsController
#   respond_to :json

#   def create
#   super
# end


#   private

#   def respond_with(resource, _opts = {})
#     render json: { message: 'Logged in successfully', user: resource }, status: :ok
#   end

#   def respond_to_on_destroy
#     head :no_content
#   end
# end
 # app/controllers/users/sessions_controller.rb
class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    render json: { 
      message: 'Logged in successfully', 
      user: {
        id: resource.id,
        email: resource.email,
        role: resource.role
      }
    }, status: :ok
  end

  def respond_to_on_destroy
    render json: { 
      message: 'Logged out successfully' 
    }, status: :ok
  end
end