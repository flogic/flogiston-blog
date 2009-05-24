class Admin::ArticlesController < AdminController
  helper 'articles'
  
  def index
    @articles = Article.all
  end
  
  def new
    @article = Article.new
  end
  
  def create
    article = Article.new(params[:article])
    article.save
    redirect_to admin_article_path(article)
  end
  
  def show
    @article = Article.find(params[:id])
  end
  
  def edit
    @article = Article.find(params[:id])
  end
  
  def update
    article = Article.find(params[:id])
    article.update_attributes(params[:article])
    redirect_to admin_article_path(article)
  end
end
