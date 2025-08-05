class Api::V1::ProductsController < ApplicationController
 before_action :authenticate_user!
  before_action :set_product, only: [:show, :update, :destroy]
  # GET /api/v1/products
  def index
    @products = Product.all
    render json: @products, status: :ok
  end

  # GET /api/v1/products/:id
  def show
    render json: @product, status: :ok
  end

  # POST /api/v1/products
#   def create
  
#     @product = Product.new(product_params)
    
#     if @product.save
#       render json: @product, status: :created
#     else
#       render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
#     end
  
 
# end
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT/PATCH /api/v1/products/:id
  def update

    if @product.update(product_params)
      render json: @product, status: :ok
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/products/:id
  def destroy

    if @product.destroy
      render json: { message: "Product deleted successfully" }, status: :ok
    else
      render json: { error: "Failed to delete product" }, status: :unprocessable_entity
    end
  end

  private

  def set_product
    @product = Product.find_by(id: params[:id])
    render json: { error: "Product not found" }, status: :not_found unless @product
  end

  def product_params
    params.require(:product).permit(:name, :description)
  end

end
