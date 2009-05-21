require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. spec_helper]))

describe Admin::ArticlesController do
  describe 'new' do
    def do_get
      get :new
    end
    
    it 'should be successful' do
      do_get
      response.should be_success
    end
    
    it 'should make a new article available to the view' do
      do_get
      assigns[:article].should be_instance_of(Article)
      assigns[:article].should be_new_record
    end
    
    it 'should render the new template' do
      do_get
      response.should render_template('admin/articles/new')
    end
    
    it 'should use the admin layout' do
      do_get
      response.layout.should == 'layouts/admin'
    end
  end
  
  describe 'create' do
    def do_post
      post :create, :article => { :title => 'What I Did This Summer', :content => "Nothing, because I'm really lazy." }
    end
    
    it 'should create a new article' do
      lambda { do_post }.should change(Article, :count).by(1)
    end
    
    it 'should use the provided attributes when creating the article' do
      Article.delete_all
      do_post
      Article.first.title.should == 'What I Did This Summer'
    end
    
    it 'should redirect to the admin show view for the new article' do
      Article.delete_all
      do_post
      response.should redirect_to(admin_article_path(Article.first))
    end
  end
end
