class Admin::ArticlesController < AdminController
  helper 'articles'
  
  def index
    @articles = Article.all
  end
  
  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(params[:article])
    
    if !preview? and @article.save
      redirect_to admin_article_path(@article)
    else
      render :action => 'new'
    end
  end
  
  def show
    @article = Article.find(params[:id])
  end
  
  def edit
    @article = Article.find(params[:id])
  end
  
  def update
    @article = Article.find(params[:id])
    @article.attributes = params[:article]
    
    if !preview? and @article.save
      redirect_to(admin_article_path(@article))
    else
      render :action => 'edit'
    end
  end
  
  
  private
  
  def preview?
    !params[:preview].blank?
  end
end
