class UserController < ApplicationController
  before_filter :authenticate_user!
 
  #List of all users
  def index
    @users = User.all
  end

  #Show user
  def show
    @user = user.find(params[:id])
  end
end
