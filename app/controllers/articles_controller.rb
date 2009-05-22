class ArticlesController < ApplicationController
  def index
    @article = Article.latest
  end
end
