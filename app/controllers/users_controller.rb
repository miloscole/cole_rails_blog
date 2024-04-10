class UsersController < ApplicationController
  include Flashable

  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      success_msg for: :account
      redirect_to users_path
    else
      render "new", status: 422
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      success_msg for: :account
      redirect_to user_path(@user)
    else
      render "edit", status: 422
    end
  end

  def destroy
    @user.destroy
    success_msg for: :account
    redirect_to articles_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
