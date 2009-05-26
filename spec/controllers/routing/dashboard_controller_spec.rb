require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. spec_helper]))

describe DashboardController do
  describe 'mapping routes' do
    it "should map { :controller => 'dashboard', :action => 'index' } to /" do
      route_for(:controller => 'dashboard', :action => 'index').should == '/'
    end
  end
  
  describe 'generating params' do
    it "should generate params { :controller => 'dashboard', action => 'index' } from GET /dashboard" do
      params_from(:get, '/dashboard').should == { :controller => 'dashboard', :action => 'index' }
    end
    
    it "should generate params { :controller => 'dashboard', action => 'index' } from GET /" do
      params_from(:get, '/').should == { :controller => 'dashboard', :action => 'index' }
    end
  end
end
