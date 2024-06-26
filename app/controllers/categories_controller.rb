class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]
  before_action :require_admin, except: %i[index show]

  def index
    @categories = Category
      .paginate(page: params[:page], per_page: 6)
      .includes(:articles)
  end

  def show
    @category_articles = @category.articles
      .paginate(page: params[:page], per_page: 4)
      .includes(:categories)
      .includes(:user)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      success_msg with: @category.name
      redirect_to categories_path
    else
      render "new", status: 422
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      success_msg with: @category.name
      redirect_to category_path(@category)
    else
      render "edit"
    end
  end

  def destroy
    @category.destroy
    success_msg with: @category.name
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def require_admin
    unless current_user.admin?
      error_msg "That action is allowed only for admin user"
      redirect_to root_path
    end
  end
end
