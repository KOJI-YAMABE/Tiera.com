class ThanksController < ApplicationController
	before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @post.thanks.create(user_id: current_user.id)
  end

  def destroy
    @post = Post.find(params[:post_id])
    thank = current_user.thanks.find_by(post_id: @post.id)
    thank.destroy
  end

  private
  def thank_params
    params.require(:post).permit(:user_id, :post_id)
  end
end
