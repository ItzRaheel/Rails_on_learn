# class ProductsController < ApplicationController
# before_action :set_product, only: %i[about edit update]



#   def login

#   end
#   def home
#     @products = Product.all
#   end
#   def about 
#     @product = Product.find(params[:id])
#   # # @product = Product.all
# end
# def new
#   @product = Product.new
  
  
# end
# def create 
#   @product = Product.new(product_params)
#   if @product.save 
#     # redirect_to @product
#     redirect_to root_path
#   else 
#     render :new
#   end
# end

# def edit
#   @product = Product.find(params[:id])
# end
# def update 
  
#   @product = Product.find(params[:id])
#     if @product = Product.update(product_params)
#     redirect_to product_about_path(@product),notice:"Product update sucessfully"
#   else 
#     render :edit ,status: :uprocessale_entity
#   end
#   def destroy
#      @product = Product.find(params[:id])
#     @product.destroy
#     redirect_to root_path,notice: "the Product are delete::"
#   end
# end

# private 
# def set_product
# @product = Product.find(params[:id])
# end
# def product_params
#   params.require(:product).permit(:name ,:description)
# end


# end
class ProductsController < ApplicationController
  before_action :set_product, only: %i[about edit update destroy]

  def home
    @products = Product.all
  end

  def about
    # @product is set by before_action
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path, notice: "Product created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # @product is set by before_action
  end

  def update
    if @product.update(product_params)
      redirect_to product_about_path(@product), notice: "Product updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to root_path, notice: "Product deleted successfully."
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description)
  end
end

