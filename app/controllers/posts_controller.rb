class PostsController < ApplicationController
  def index
    @posts = Post.all.page(params[:page]).per(4)
  end

  def show
  if user_signed_in?
      @post = Post.find(params[:id])
      @post_comment = PostComment.new
      @post_comments = @post.post_comments.order(created_at: :desc)
      @post_tags = @post.tags
      # @lat = @post.spot.latitude
      # @lng = @post.spot.longitude
      # gon.lat = @lat
      # gon.lng = @lng
    else
      flash[:success] = "ここから先はログインが必要です！"
      redirect_to new_user_session_path
    end
  end

  def edit
    ＠posts = Post.find(params[:id])
  end

  def new
    @post = Post.new
    # @tag_list = @post.tags.pluck(:tag_name).split(nil)
    # @post.build_spot
    # gon.my_private_key = ENV["GOOGLE_API_KEY"]
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    # tag_list = params[:post][:tag_name].split(nil)
       if @post.save
          # @post.save_tag(tag_list)
          flash[:success] = "投稿が保存されました！"
          redirect_to post_path(@post)
       else
         render 'new'
       end
  end

  def update
  end

  def destroy
  end

  private
  def post_params
    params.require(:post).permit(:image, :garbage_count, :content, :join_amount, :published_at)
  end

end
