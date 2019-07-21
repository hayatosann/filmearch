class ProductsController < ApplicationController
 
  def index
    @product = Product.order('id DESC').limit(3)
  end
  
  def show
  end

  def search
  end
end
