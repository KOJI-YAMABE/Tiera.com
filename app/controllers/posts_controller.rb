class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
  end

  def edit
  end

  def new
  end

  def create
  end

  def update
  end

  def destroy
  end

  private
  def book_params
    params.require(:post).permit(:image, :garbage_count, :content, :join_amount)
  end

end
