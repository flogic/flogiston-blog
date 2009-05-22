require File.expand_path(File.join(File.dirname(__FILE__), %w[.. spec_helper]))

describe Article do
  before :each do
    @article = Article.new
  end
  
  describe 'attributes' do
    it 'should have content' do
      @article.should respond_to(:content)
    end
    
    it 'should have a title' do
      @article.should respond_to(:title)
    end
    
    it 'should have a creation time' do
      @article.should respond_to(:created_at)
    end
    
    it 'should have a publication time' do
      @article.should respond_to(:published_at)
    end
  end
  
  describe 'publication time' do
    it 'should be settable' do
      t = Time.zone.local(2007, 3, 4, 1, 2, 3)
      article = Article.generate!(:published_at => t)
      article.reload
      article.published_at.should == t
    end
    
    it 'should allow a future time' do
      t = Time.zone.now + 12345
      t = Time.zone.local(t.year, t.month, t.day, t.hour, t.min, t.sec)  # milliseconds, yay
      article = Article.generate!(:published_at => t)
      article.reload
      article.published_at.should == t
    end
    
    it 'should default to creation time' do
      article = Article.generate!
      article.published_at.should == article.created_at
    end
    
    it 'should be set to creation time if explicitly set to nil' do
      article = Article.generate!(:published_at => nil)
      article.published_at.should == article.created_at
    end
  end
  
  describe 'as a class' do
    it 'should be able to give the most recent article' do
      Article.should respond_to(:latest)
    end
    
    describe 'giving the most recent article' do
      it 'should return the article with the latest publication time' do
        t = Time.zone.now
        Article.delete_all
        articles = []
        articles.push Article.generate!(:published_at => t - 30)
        articles.push Article.generate!(:published_at => t + 500)
        articles.push Article.generate!(:published_at => t + 3)
        
        Article.latest.should == articles[1]
      end
      
      it 'should return nil if there are no articles' do
        Article.delete_all
        Article.latest.should be_nil
      end
    end
    
    it 'should return articles in publication time order, most recent first' do
      t = Time.zone.now
      Article.delete_all
      articles = []
      articles.push Article.generate!(:published_at => t - 30)
      articles.push Article.generate!(:published_at => t + 500)
      articles.push Article.generate!(:published_at => t + 3)
      
      Article.all.should == articles.values_at(1,2,0)
    end
    
    it 'should allow article order to be overridden' do
      t = Time.zone.now
      Article.delete_all
      articles = []
      articles.push Article.generate!(:published_at => t - 30)
      articles.push Article.generate!(:published_at => t + 500)
      articles.push Article.generate!(:published_at => t + 3)
      
      Article.all(:order => 'published_at ASC').should == articles.values_at(0,2,1)
    end
  end
end
