class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all.page(params[:page])
    gon.my_private_key = ENV["GOOGLE_API_KEY"]
    lat_lng = []
    i = 0
    @posts.each do |post|
      if post.spot
        lat_lng[i] = { latitude: "#{post.spot.latitude}", longitude: "#{post.spot.longitude}" }
        i += 1
      end
    end
    gon.lat_lng = lat_lng
  end

  def show
    if user_signed_in?
      @post = Post.find(params[:id])
      @post_comment = PostComment.new
      @post_comments = @post.post_comments
      lat_lng = []
      lat_lng[0] = { latitude: "#{@post.spot.latitude}", longitude: "#{@post.spot.longitude}" }
      gon.lat_lng = lat_lng
    else
      flash[:success] = "ここから先はログインが必要です！"
      redirect_to new_user_session_path
    end
  end

  def edit
    @post = Post.find(params[:id])
    gon.my_private_key = ENV["GOOGLE_API_KEY"]
    if current_user.id != @book.user_id
      redirect_to books_path
    end
  end

  def new
    @post = Post.new
    @post.build_spot
    gon.my_private_key = ENV["GOOGLE_API_KEY"]
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      tags = Vision.get_image_data(@post.image)
      tags.each do |tag|
        @post.tags.create(tag_name: tag)
      end
      flash[:success] = "投稿が保存されました！"
      redirect_to posts_path(@post)
    else
      render 'new'
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = "写真が更新されました！"
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_url
  end

  private

  def post_params
    params.require(:post).permit(:image, :garbage_count, :content, :join_amount, :published_at, spot_attributes: [:address, :latitude, :longitude])
  end
end
