class ArticlesController < ApplicationController
  def index
    @article = Article.first(:order => 'published_at DESC')
  end
end
