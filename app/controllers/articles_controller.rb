class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  before_action :require_user, except: %i[index show]
  before_action :require_article_creator_or_admin, only: %i[edit update destroy]

  def index
    @articles = Article
      .paginate(page: params[:page], per_page: 6)
      .order(created_at: "desc")
      .includes(:user)
      .includes(:categories)
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      success_msg with: @article.title
      redirect_to articles_path
    else
      render "new", status: 422
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      success_msg with: @article.title
      redirect_to article_path(@article)
    else
      render "edit", status: 422
    end
  end

  def destroy
    @article.destroy
    success_msg with: @article.title
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :text, category_ids: [])
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def require_article_creator_or_admin
    unless actions_allowed_on_article?
      error_msg "You can delete or edit only your own article"
      redirect_to root_path
    end
  end
end
