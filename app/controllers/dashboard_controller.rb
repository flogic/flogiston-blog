class DashboardController < ApplicationController
  def index
    @article = Article.latest
  end
end
