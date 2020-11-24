class PostCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @post_comment = @post.post_comments.new(post_comment_params)
    @post_comment.user_id = current_user.id
    if @post_comment.save
      @post_comments = PostComment.all
    else
      @post_comments = PostComment.all
    end
  end

  def destroy
    @post_comment = PostComment.find(params[:post_id])
    @post = @post_comment.post
    if @post_comment.user != current_user
      @post_comments = PostComment.all
      redirect_to request.referer
    else
      @post_comment.destroy
      @post_comments = PostComment.all
    end
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
