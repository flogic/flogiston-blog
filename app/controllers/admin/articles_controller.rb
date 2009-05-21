class Admin::ArticlesController < ApplicationController
  layout 'admin'
  
  def new
    @article = Article.new
  end
  
  def create
    article = Article.new(params[:article])
    article.save
    redirect_to admin_article_path(article)
  end
end
