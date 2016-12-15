class UsersController < ApplicationController
  before_action :find_user, only: [:won, :lost]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      render :new
    end
  end

  def index
    @users = User.all.order(points: :desc)
  end

  def won
    @user.points += 3
    @user.save
    redirect_to users_path
  end

  def lost
    @user.points += 1
    @user.save
    redirect_to users_path
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
