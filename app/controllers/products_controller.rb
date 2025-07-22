class ProductsController < ApplicationController
  def login
  end
  def home
    @products = Product.all
  end
  def about 
  @product = Product.find(parmas[:id])
  end
end
