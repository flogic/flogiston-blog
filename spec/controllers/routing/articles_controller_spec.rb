require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. spec_helper]))

describe ArticlesController do
  describe 'mapping routes' do
    it "should map { :controller => 'articles', :action => 'index' } to /articles" do
      route_for(:controller => 'articles', :action => 'index').should == '/articles'
    end
  end
  
  describe 'generating params' do
    it "should generate params { :controller => 'articles', action => 'index' } from GET /articles" do
      params_from(:get, '/articles').should == { :controller => 'articles', :action => 'index' }
    end
    
    it "should generate params { :controller => 'articles', action => 'index' } from GET /" do
      params_from(:get, '/').should == { :controller => 'articles', :action => 'index' }
    end
  end
end
