class UsersController < ApplicationController
	before_action :authenticate_user!
  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
  end

  def withdraw
  end

  private
def user_params
  params.require(:user).permit(:name, :introduction, :profile_image, :phone_number, :user_type, :is_deleted)
end
end
