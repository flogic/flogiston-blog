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
end
