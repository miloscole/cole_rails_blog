class ArticlesController < ApplicationController
  include Flashable

  before_action :set_article, only: %i[show edit update destroy]

  def index
    @articles = Article.all
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

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
      redirect_to article_path
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
    params.require(:article).permit(:title, :text)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end