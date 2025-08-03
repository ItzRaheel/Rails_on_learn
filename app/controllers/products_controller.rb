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
  before_action :set_product, only: %i[show about edit update destroy]
  before_action :authenticate_user!,only: %i[show about edit update destroy]
  after_action :verify_policy_scoped ,only: [:home]
  
  # load_and_authorize_resource 
  include Pundit
# rescue_from CanCan::AccessDenied do |exception|
#   flash[:notice]= "Only admin can acess these  pages SHOW ,Delete,update"
#   redirect_to root_path
# end


  def home
    # @product = Product.accessible_by(current_ability)
     
    if current_user&.has_role?(:admin)
      @admin_content = "Wellcome Admin"
    elsif current_user&.has_role?(:user)
      flash[:alert] = "Wellcome to user"
    else 
      flash[:alert] = "Wellcome to Guest"

    end  
    # if current_user&.admin?
    #   @admin_content = "Wellcome Admin"
    # else
    #   flash[:alert] = "not an admin"
   
    # end

    @pagy,@products =pagy(policy_scope(Product),items: 4)
    # @pagy,@products =pagy(Product.all, items: 4)
    
    # @products = Product.all
    # @products = policy_scope(Product)
    #  @publications = ApplicationPolicy::Scope.new(current_user, Product).resolve
    # @product = policy_scope(Product)
    
  end
  def show
    authorize @product

    # @product is set by before_action
  end
  

  def about
    
    authorize @product
    # @product is set by before_action
  end

  def new
    @product = Product.new
    authorize @product

  end

  def create
    # @product = Product.new(product_params)
    @product = current_user.products.build(product_params)

    authorize @product

    if @product.save
      flash[:notice] = "Product created successfully."
      redirect_to new_product_path
    else
      flash[:alert] = "not created product"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @product

    # @product is set by before_action
  end

  def update
    authorize @product

    if @product.update(product_params)
      redirect_to product_about_path(@product), notice: "Product updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
      @product = Product.find(params[:id])

    authorize @product

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

