class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :require_same_user, only: %i[edit update]

  def index
    @users = User.paginate(page: params[:page], per_page: 6).order(created_at: "desc")
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 4)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
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
    if current_user&.admin? && @user != current_user
      @user.destroy
      success_msg for: :account
      redirect_to users_path
    else
      error_msg "Only admin user can delete other non admin users"
      redirect_to users_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    unless current_user == @user
      error_msg "Your can only edit your own account"
      redirect_to root_path
    end
  end
end
