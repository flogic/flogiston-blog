class ArticlesController < ApplicationController
  def index
    @article = Article.latest
  end
  
  def show
    @article = Article.find(params[:id])
  end
end
