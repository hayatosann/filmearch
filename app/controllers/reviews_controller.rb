class ReviewsController < ApplicationController

 def new
  # @user = User.find(3)
  @product = Product.find(params[:product_id])
  @review = Review.new
 end

 def create
  Review.create(create_params)
  redirect_to controller: :products, action: :index
 end

 def destroy
  review = Review.find(params[:id])
  @review=review.destroy if review.user.nickname == current_user.nickname
  redirect_to controller: :products, action: :index
 end

#  def edit
#   @review = Review.find(params[:id])
#  end

#  def update
#   review = Review.find(params[:id])
#   if review.user.nickname == current_user.nickname
#     review.update(create_params)
#   end
# end

 private
  def create_params
    params.require(:review).permit(:rate, :review).merge(user_id: current_user.id, product_id: params[:product_id])
  end

end
