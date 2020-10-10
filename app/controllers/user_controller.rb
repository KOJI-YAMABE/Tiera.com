class UserController < ApplicationController
	before_action :authenticate_user!, only[:edit]
  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  def withdraw
  end
end
