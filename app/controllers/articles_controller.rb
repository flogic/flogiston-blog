class ArticlesController < ApplicationController
  def index
    @article = Article.first(:order => 'created_at DESC')
  end
end
