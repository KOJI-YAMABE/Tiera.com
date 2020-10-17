class PostCommentsController < ApplicationController
	before_action :authenticate_user!

  def create
  	@post = Post.find(params[:post_id])
    @post_comment = @post.post_comments.new(post_comment_params)
    @post_comment.user_id = current_user.id
    if @post_comment.save
      redirect_to post_path(@post)
    else
      @post_comments = PostComment.where(id: @post)
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
  	@post_comment = PostComment.find(params[:post_comment_id])
    if @post_comment.user != current_user
      redirect_to request.referer
    end
    @post_comment.destroy
  end

   private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
