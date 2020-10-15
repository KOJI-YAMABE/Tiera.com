class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
  end

  def edit
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
          @post.save_tag(tag_list)
          flash[:success] = "投稿が保存されました！"
          redirect_to posts_path
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
    params.require(:post).permit()
  end

end
