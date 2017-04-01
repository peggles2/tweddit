class UserController < ApplicationController
  before_filter :authenticate_user!
  def index
    @users = User.all
  end
  def show
    @user = user.find(params[:id])
  end
end
