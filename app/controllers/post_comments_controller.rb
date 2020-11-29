class PostCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @post_comment = @post.post_comments.new(post_comment_params)
    @post_comment.user_id = current_user.id
    @post_comment.save
    @post_comments = @post.post_comments
  end

  def destroy
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
    @post_comments = @post.post_comments
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
