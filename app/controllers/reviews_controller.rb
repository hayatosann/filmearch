class ReviewsController < ApplicationController

 def new
  # @user = User.find(3)
  @product = Product.find(params[:product_id])
  @review = Review.new
 end

 def create
  Review.create(create_params)
  # binding.pry
  redirect_to controller: :products, action: :index
 end

 private
  def create_params
    params.require(:review).permit(:rate, :review).merge(user_id: current_user.id, product_id: params[:product_id])
  end

end
