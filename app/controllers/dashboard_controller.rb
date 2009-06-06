class DashboardController < ApplicationController
  helper 'articles'
  
  def index
    @article = Article.latest
  end
end
