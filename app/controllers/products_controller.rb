class ProductsController < ApplicationController
 
  def index
    @products = Product.order('id ASC').page(params[:page]).per(18)
    product_ids = Review.group(:product_id).order('count_product_id DESC').limit(5).count(:product_id).keys
    @ranking = product_ids.map { |id| Product.find(id) }
    @product =Product.find(1)
    @review = Review.new
    # @res = Amazon::Ecs.item_search("検索したいキーワード",
    #   :search_index   => 'Books',
    #   :response_group => 'Medium',
    #   :country        => 'jp'
    # )
  end

  
  def show
    @product = Product.find(params[:id])
  end

  def search
    @products = Product.where('title LIKE(?)', "%#{params[:keyword]}%").limit(20)
  end

  private
  def create_params
    params.require(:review).permit(:rate, :review).merge(user_id: current_user.id, product_id: params[:product_id])
  end
end

