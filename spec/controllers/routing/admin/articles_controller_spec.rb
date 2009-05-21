require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. .. spec_helper]))

describe Admin::ArticlesController do
  describe 'mapping routes' do
    it "should map { :controller => 'admin/articles', :action => 'index' } to /admin/articles" do
      route_for(:controller => 'admin/articles', :action => 'index').should == '/admin/articles'
    end
    
    it "should map { :controller => 'admin/articles', :action => 'new' } to /admin/articles/new" do
      route_for(:controller => 'admin/articles', :action => 'new').should == '/admin/articles/new'
    end
    
    it "should map { :controller => 'admin/articles', :action => 'create' } to /admin/articles" do
      route_for(:controller => 'admin/articles', :action => 'create').should == { :path => '/admin/articles', :method => :post }
    end
    
    it "should map { :controller => 'admin/articles', :action => 'show', :id => '1' } to /admin/articles/1" do
      route_for(:controller => 'admin/articles', :action => 'show', :id => '1').should == '/admin/articles/1'
    end
    
    it "should map { :controller => 'admin/articles', :action => 'edit', :id => '1' } to /admin/articles/1/edit" do
      route_for(:controller => 'admin/articles', :action => 'edit', :id => '1').should == '/admin/articles/1/edit'
    end
    
    it "should map { :controller => 'admin/articles', :action => 'update', :id => '1' } to /admin/articles/1" do
      route_for(:controller => 'admin/articles', :action => 'update', :id => '1').should == { :path => '/admin/articles/1', :method => :put }
    end
    
    it "should map { :controller => 'admin/articles', :action => 'destroy', :id => '1' } to /admin/articles/1" do
      route_for(:controller => 'admin/articles', :action => 'destroy', :id => '1').should == { :path => '/admin/articles/1', :method => :delete }
    end
  end
  
  describe 'generating params' do
    it "should generate params { :controller => 'admin/articles', action => 'index' } from GET /admin/articles" do
      params_from(:get, '/admin/articles').should == { :controller => 'admin/articles', :action => 'index' }
    end
    
    it "should generate params { :controller => 'admin/articles', action => 'new' } from GET /admin/articles/new" do
      params_from(:get, '/admin/articles/new').should == { :controller => 'admin/articles', :action => 'new' }
    end
    
    it "should generate params { :controller => 'admin/articles', action => 'create' } from POST /admin/articles/new" do
      params_from(:post, '/admin/articles').should == { :controller => 'admin/articles', :action => 'create' }
    end
    
    it "should generate params { :controller => 'admin/articles', action => 'show', :id => '1' } from GET /admin/articles/1" do
      params_from(:get, '/admin/articles/1').should == { :controller => 'admin/articles', :action => 'show', :id => '1' }
    end
    
    it "should generate params { :controller => 'admin/articles', action => 'edit', :id => '1' } from GET /admin/articles/1/edit" do
      params_from(:get, '/admin/articles/1/edit').should == { :controller => 'admin/articles', :action => 'edit', :id => '1' }
    end
    
    it "should generate params { :controller => 'admin/articles', action => 'update', :id => '1' } from PUT /admin/articles/1" do
      params_from(:put, '/admin/articles/1').should == { :controller => 'admin/articles', :action => 'update', :id => '1' }
    end
    
    it "should generate params { :controller => 'admin/articles', action => 'destroy', :id => '1' } from DELETE /admin/articles/1" do
      params_from(:delete, '/admin/articles/1').should == { :controller => 'admin/articles', :action => 'destroy', :id => '1' }
    end
  end
end
