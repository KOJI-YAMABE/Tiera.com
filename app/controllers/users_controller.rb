class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_user

  def show
    @posts = @user.posts.page(params[:page]).per(4)
    @posts_all = Post.all
    @follow_users = @user.following_user
    @follower_posts = @posts_all.where(user_id: @follow_users).order("created_at DESC")
  end

  def edit
    if current_user != @user
      redirect_to user_path(current_user)
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def withdraw
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :introduction, :profile_image, :phone_number, :user_type)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
