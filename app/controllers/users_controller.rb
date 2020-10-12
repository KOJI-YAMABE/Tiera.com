class UsersController < ApplicationController
	before_action :authenticate_user!
  def index
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts

    @posts_all = Post.all
   #フォローしているユーザーを取得
    @follow_users = @user.following_user
   #フォローユーザーのツイートを表示
    @follower_posts = @posts_all.where(user_id: @follow_users).order("created_at DESC")
 
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to request.referer, notice: '会員情報の更新が完了しました。'
    else
      render :edit
    end
  end

  def withdraw
    @user = User.find(params[:id])
    #is_deletedカラムにフラグを立てる
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end

  private
def user_params
  params.require(:user).permit(:name, :introduction, :profile_image, :phone_number, :user_type, :is_deleted)
end
end
