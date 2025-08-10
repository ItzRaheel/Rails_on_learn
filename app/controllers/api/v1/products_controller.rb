# class Api::V1::ProductsController < Api::V1::BaseController
#   before_action :set_product, only: [:show, :update, :destroy]
#   # GET /api/v1/products
#   def index
#     @products = Product.all
#     render json: @products, status: :ok
#   end

#   # GET /api/v1/products/:id
#   def show
#     render json: @product, status: :ok
#   end

#   # POST /api/v1/products
# #   def create
  
# #     @product = Product.new(product_params)
    
# #     if @product.save
# #       render json: @product, status: :created
# #     else
# #       render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
# #     end
  
 
# # end
#   def create
#     @product = Product.new(product_params)

#     if @product.save
#       render json: @product, status: :created
#     else
#       render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
#     end
#   end

#   # PUT/PATCH /api/v1/products/:id
#   def update

#     if @product.update(product_params)
#       render json: @product, status: :ok
#     else
#       render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
#     end
#   end

#   # DELETE /api/v1/products/:id
#   def destroy

#     if @product.destroy
#       render json: { message: "Product deleted successfully" }, status: :ok
#     else
#       render json: { error: "Failed to delete product" }, status: :unprocessable_entity
#     end
#   end

#   private

#   def set_product
#     @product = Product.find_by(id: params[:id])
#     render json: { error: "Product not found" }, status: :not_found unless @product
#   end

#   def product_params
#     params.require(:product).permit(:name, :description)
#   end

# end





# using this controller if not workin
# app/controllers/api/v1/products_controller.rb
class Api::V1::ProductsController < Api::V1::BaseController
    before_action :authenticate_user!
  before_action :set_product, only: [:show, :update, :destroy]

  def index
    @products = Product.all
    render json: {
      status: 'success',
      message: 'Products retrieved successfully',
      data: @products
    }, status: :ok
  end

  def show
    render json: {
      status: 'success',
      message: 'Product retrieved successfully',
      data: @product
    }, status: :ok
  end

  def create
    # @product = Product.new(product_params)

    @product = current_user.products.build(product_params)
    
    if @product.save
      render json: {
        status: 'success',
        message: 'Product created successfully',
        data: @product
      }, status: :created
    else
      render json: {
        status: 'error',
        message: 'Product creation failed',
        errors: @product.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: {
        status: 'success',
        message: 'Product updated successfully',
        data: @product
      }, status: :ok
    else
      render json: {
        status: 'error',
        message: 'Product update failed',
        errors: @product.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def destroy
    if @product.destroy
      render json: {
        status: 'success',
        message: 'Product deleted successfully'
      }, status: :ok
    else
      render json: {
        status: 'error',
        message: 'Failed to delete product'
      }, status: :unprocessable_entity
    end
  end
  

  private

  
  def set_product
    @product = current_user.products.find_by(id: params[:id])
    unless @product
      render json: {
        status: 'error',
        message: 'Product not found'
      }, status: :not_found
    end
  end

  def product_params
    params.require(:product).permit(:name, :description)
  end
end
# app/controllers/api/v1/products_controller.rb
# class Api::V1::ProductsController < Api::V1::BaseController
#   before_action :set_product, only: [:show, :update, :destroy]

#   def index
#     @products = Product.all
#     render json: {
#       status: 'success',
#       message: 'Products retrieved successfully',
#       data: @products
#     }, status: :ok
#   end

#   def show
#     render json: {
#       status: 'success',
#       message: 'Product retrieved successfully',
#       data: @product
#     }, status: :ok
#   end

#   def create
#     # Debug: Check if current_user is present
#     unless current_user
#       render json: {
#         status: 'error',
#         message: 'Authentication required. User not found.'
#       }, status: :unauthorized and return
#     end
    
#     # Debug: Check if user has products association
#     unless current_user.respond_to?(:products)
#       render json: {
#         status: 'error',
#         message: 'User does not have products association'
#       }, status: :internal_server_error and return
#     end
    
#     @product = current_user.products.build(product_params)
    
#     if @product.save
#       render json: {
#         status: 'success',
#         message: 'Product created successfully',
#         data: @product
#       }, status: :created
#     else
#       render json: {
#         status: 'error',
#         message: 'Product creation failed',
#         errors: @product.errors.full_messages
#       }, status: :unprocessable_entity
#     end
#   end

#   def update
#     if @product.update(product_params)
#       render json: {
#         status: 'success',
#         message: 'Product updated successfully',
#         data: @product
#       }, status: :ok
#     else
#       render json: {
#         status: 'error',
#         message: 'Product update failed',
#         errors: @product.errors.full_messages
#       }, status: :unprocessable_entity
#     end
#   end

#   def destroy
#     if @product.destroy
#       render json: {
#         status: 'success',
#         message: 'Product deleted successfully'
#       }, status: :ok
#     else
#       render json: {
#         status: 'error',
#         message: 'Failed to delete product'
#       }, status: :unprocessable_entity
#     end
#   end

#   private

#   def set_product
#     @product = current_user.products.find_by(id: params[:id])
#     unless @product
#       render json: {
#         status: 'error',
#         message: 'Product not found'
#       }, status: :not_found
#     end
#   end

#   def product_params
#     params.require(:product).permit(:name, :description)
#   end
# end







# class Api::V1::ProductsController < Api::V1::BaseController
#   before_action :authenticate_user!
#   before_action :set_product, only: [:show, :update, :destroy]

#   def index
#     @products = Product.all
#     render json: {
#       status: 'success',
#       message: 'Products retrieved successfully',
#       data: @products
#     }, status: :ok
#   end

#   def show
#     render json: {
#       status: 'success',
#       message: 'Product retrieved successfully',
#       data: @product
#     }, status: :ok
#   end

#   def create
#     @product = current_user.products.build(product_params)
        
#     if @product.save
#       render json: {
#         status: 'success',
#         message: 'Product created successfully',
#         data: @product
#       }, status: :created
#     else
#       render json: {
#         status: 'error',
#         message: 'Product creation failed',
#         errors: @product.errors.full_messages
#       }, status: :unprocessable_entity
#     end
#   end

#   def update
#     if @product.update(product_params)
#       render json: {
#         status: 'success',
#         message: 'Product updated successfully',
#         data: @product
#       }, status: :ok
#     else
#       render json: {
#         status: 'error',
#         message: 'Product update failed',
#         errors: @product.errors.full_messages
#       }, status: :unprocessable_entity
#     end
#   end

#   def destroy
#     if @product.destroy
#       render json: {
#         status: 'success',
#         message: 'Product deleted successfully'
#       }, status: :ok
#     else
#       render json: {
#         status: 'error',
#         message: 'Failed to delete product'
#       }, status: :unprocessable_entity
#     end
#   end
      
#   private
  
#   # Complete authentication method
#   def authenticate_user!
#     puts "=== AUTHENTICATION DEBUG ==="
#     puts "Request method: #{request.method}"
#     puts "Request path: #{request.path}"
#     puts "Request params: #{params.inspect}"
#     puts "All headers:"
#     request.headers.each do |key, value|
#       puts "  #{key}: #{value}" if key.to_s.downcase.include?('auth') || key.to_s.downcase.include?('content')
#     end
    
#     auth_header = request.headers['Authorization']
#     puts "Authorization header: #{auth_header.inspect}"
    
#     token = auth_header&.gsub(/^Bearer\s/, '')
#     puts "Extracted token: #{token.inspect}"
#     puts "Token segments: #{token&.split('.')&.length}"
    
#     if token.blank?
#       puts "DEBUG: No token provided"
#       render json: { 
#         status: 'error',
#         message: 'No token provided' 
#       }, status: :unauthorized
#       return
#     end
    
#     begin
#       # Decode JWT token
#       secret_key = Rails.application.credentials.secret_key_base || 
#                    Rails.application.secrets.secret_key_base ||
#                    ENV['SECRET_KEY_BASE']
                   
#       puts "DEBUG: Using secret key length: #{secret_key&.length}"
      
#       decoded_token = JWT.decode(token, secret_key, true, { algorithm: 'HS256' })
#       payload = decoded_token.first
      
#       puts "DEBUG: Token decoded successfully"
#       puts "DEBUG: Payload: #{payload}"
      
#       # Extract user ID from token payload
#       user_id = payload['user_id'] || payload['id'] || payload['sub']
#       puts "DEBUG: Looking for user with ID: #{user_id}"
      
#       # Find and set current user
#       @current_user = User.find_by(id: user_id)
      
#       if @current_user.nil?
#         puts "DEBUG: User not found with ID: #{user_id}"
#         render json: { 
#           status: 'error',
#           message: 'User not found' 
#         }, status: :unauthorized
#         return
#       end
      
#       puts "DEBUG: User authenticated successfully: #{@current_user.email}"
      
#     rescue JWT::ExpiredSignature => e
#       puts "DEBUG: Token expired: #{e.message}"
#       render json: { 
#         status: 'error',
#         message: 'Token expired' 
#       }, status: :unauthorized
#     rescue JWT::DecodeError => e
#       puts "DEBUG: JWT decode error: #{e.message}"
#       puts "DEBUG: Token was: #{token}"
#       render json: { 
#         status: 'error',
#         message: 'Invalid JWT token',
#         details: e.message 
#       }, status: :unauthorized
#     rescue => e
#       puts "DEBUG: Other authentication error: #{e.class} - #{e.message}"
#       render json: { 
#         status: 'error',
#         message: 'Authentication failed',
#         details: e.message 
#       }, status: :unauthorized
#     end
#   end
  
#   # Make current_user available
#   def current_user
#     @current_user
#   end

#   def set_product
#     puts "DEBUG: Looking for product with ID: #{params[:id]} for user: #{current_user&.id}"
    
#     @product = current_user.products.find_by(id: params[:id])
    
#     unless @product
#       puts "DEBUG: Product not found or doesn't belong to user"
#       render json: {
#         status: 'error',
#         message: 'Product not found or access denied'
#       }, status: :not_found
#       return
#     end
    
#     puts "DEBUG: Product found: #{@product.name}"
#   end

#   def product_params
#     params.require(:product).permit(:name, :description, :price)
#   end
# end