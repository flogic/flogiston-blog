require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. spec_helper]))

describe ArticlesController do
  describe 'mapping routes' do
    it "should map { :controller => 'articles', :action => 'index' } to /articles" do
      route_for(:controller => 'articles', :action => 'index').should == '/articles'
    end

    it "should map { :controller => 'articles', :action => 'show', :id => '1' } to /articles/1" do
      route_for(:controller => 'articles', :action => 'show', :id => '1').should == '/articles/1'
    end
  end
  
  describe 'generating params' do
    it "should generate params { :controller => 'articles', action => 'index' } from GET /articles" do
      params_from(:get, '/articles').should == { :controller => 'articles', :action => 'index' }
    end
    
    it "should generate params { :controller => 'articles', action => 'show', :id => '1' } from GET /articles/1" do
      params_from(:get, '/articles/1').should == { :controller => 'articles', :action => 'show', :id => '1' }
    end

    it "should generate params { :controller => 'articles', action => 'index' } from GET /" do
      params_from(:get, '/').should == { :controller => 'articles', :action => 'index' }
    end
  end
end
