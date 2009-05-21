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
  end
end
