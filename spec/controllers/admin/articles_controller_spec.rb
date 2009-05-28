require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. spec_helper]))

describe Admin::ArticlesController do
  describe 'index' do
    before :each do
      @articles = Array.new(3) { |i|  Article.generate!(:published_at => Time.zone.now + i) }
    end
    
    def do_get
      get :index
    end
    
    it 'should be successful' do
      do_get
      response.should be_success
    end
    
    it 'should make the articles available to the view in creation order, most recent first' do
      do_get
      assigns[:articles].should == @articles.reverse
    end
    
    it 'should make an empty array available to the view if there are no articles' do
      Article.delete_all
      do_get
      assigns[:articles].should == []
    end
    
    it 'should render the index template' do
      do_get
      response.should render_template('admin/articles/index')
    end
    
    it 'should use the admin layout' do
      do_get
      response.layout.should == 'layouts/admin'
    end
  end
  
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
    before :each do
      @article = Article.spawn
    end
    
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
    
    describe 'and previewing' do
      before :each do
        @new_content = 'new content go here'
      end
      
      def do_post
        post :create, :article => @article.attributes.merge('content' => @new_content), :preview => true
      end
      
      it 'should make the requested article available to the view' do
        do_post
        assigns[:article].should be_kind_of(Article)
      end
      
      it 'should set the article attributes' do
        do_post
        assigns[:article].content.should == @new_content
      end
      
      it 'should not save the article' do
        lambda { do_post }.should_not change(Article, :count)
      end

      it 'should render the new template' do
        do_post
        response.should render_template('admin/articles/new')
      end

      it 'should use the admin layout' do
        do_post
        response.layout.should == 'layouts/admin'
      end
    end
    
    describe 'with an empty preview parameter' do
      def do_post
        post :create, :article => @article.attributes, :preview => ''
      end
      
      it 'should create a new article' do
        lambda { do_post }.should change(Article, :count).by(1)
      end
    end
    
    describe 'when saving is unsuccessful' do
      before :each do
        @article.title = 'Test Title #198273'
        Article.any_instance.stubs(:save).returns(false)
      end
      
      def do_post
        post :create, :article => @article.attributes
      end
      
      it 'should be successful' do
        do_post
        response.should be_success
      end
      
      it 'should make a new article available to the view' do
        do_post
        assigns[:article].should be_new_record
      end
      
      it 'should initialize the article with the given attributes' do
        do_post
        assigns[:article].title.should == @article.title
      end
      
      it 'should render the new template' do
        do_post
        response.should render_template('admin/articles/new')
      end
      
      it 'should use the admin layout' do
        do_post
        response.layout.should == 'layouts/admin'
      end
    end
  end
  
  describe 'show' do
    before :each do
      @article = Article.generate!
      @article_id = @article.id.to_s
    end
    
    def do_get
      get :show, :id => @article_id
    end
    
    it 'should be successful' do
      do_get
      response.should be_success
    end
    
    it 'should find the requested article' do
      Article.expects(:find).with(@article_id).returns(@article)
      do_get
    end
    
    it 'should make the found article' do
      do_get
      assigns[:article].should == @article
    end
    
    it 'should render the show template' do
      do_get
      response.should render_template('admin/articles/show')
    end
    
    it 'should use the admin layout' do
      do_get
      response.layout.should == 'layouts/admin'
    end
  end
  
  describe 'edit' do
    before :each do
      @article = Article.generate!
      @article_id = @article.id.to_s
    end
    
    def do_get
      get :edit, :id => @article_id
    end
    
    it 'should find the requested article' do
      Article.expects(:find).with(@article_id).returns(@article)
      do_get
    end
    
    it 'should make the found article' do
      do_get
      assigns[:article].should == @article
    end
    
    it 'should render the edit template' do
      do_get
      response.should render_template('admin/articles/edit')
    end
    
    it 'should use the admin layout' do
      do_get
      response.layout.should == 'layouts/admin'
    end
  end
  
  describe 'update' do
    before :each do
      @article = Article.generate!(:title => 'What I Did Last Summer', :content => 'Everything!')
      @article_id = @article.id.to_s
    end
    
    def do_put
      put :update, :id => @article_id, :article => { :title => 'What I Did This Summer', :content => "Nothing, because I'm really lazy." }
    end
    
    it 'should find the requested article' do
      Article.expects(:find).with(@article_id).returns(@article)
      do_put
    end
    
    it 'should use the provided attributes when updating the article' do
      do_put
      @article.reload
      @article.title.should == 'What I Did This Summer'
    end
    
    it 'should redirect to the admin show view for the requested article' do
      do_put
      response.should redirect_to(admin_article_path(@article))
    end
    
    describe 'and previewing' do
      before :each do
        @new_content = 'new content goes here'
      end
      
      def do_put
        put :update, :id => @article_id, :article => @article.attributes.merge('content' => @new_content), :preview => true
      end
      
      it 'should make the requested article available to the view' do
        do_put
        assigns[:article].id.should == @article.id
      end
      
      it 'should set the article attributes' do
        do_put
        assigns[:article].content.should == @new_content
      end
      
      it 'should not save the attributes' do
        do_put
        Article.find(@article_id).content.should_not == @new_content
      end

      it 'should render the edit template' do
        do_put
        response.should render_template('admin/articles/edit')
      end

      it 'should use the admin layout' do
        do_put
        response.layout.should == 'layouts/admin'
      end
    end
    
    describe 'with an empty preview parameter' do
      before :each do
        @new_title = 'New Title Goes Here'
      end
      
      def do_put
        put :update, :id => @article_id, :article => @article.attributes.merge('title' => @new_title), :preview => ''
      end
      
      it 'should update the article with the provided attributes' do
        do_put
        Article.find(@article_id).title.should == @new_title
      end
    end
    
    describe 'when saving is unsuccessful' do
      before :each do
        @article.stubs(:save).returns(false)
        Article.stubs(:find).with(@article_id).returns(@article)
        @new_title = 'Some Other Title, Yes'
      end
      
      def do_put
        put :update, :id => @article_id, :article => @article.attributes.merge('title' => @new_title)
      end
      
      it 'should be successful' do
        do_put
        response.should be_success
      end
      
      it 'should make the requested article available to the view' do
        do_put
        assigns[:article].id.should == @article.id
      end
      
      it 'should set the article attributes' do
        do_put
        assigns[:article].title.should == @new_title
      end
      
      it 'should render the edit template' do
        do_put
        response.should render_template('admin/articles/edit')
      end
      
      it 'should use the admin layout' do
        do_put
        response.layout.should == 'layouts/admin'
      end
    end
  end
  
  describe 'destroy' do
    before :each do
      @article = Article.generate!
      @article_id = @article.id.to_s
    end

    def do_delete
      delete :destroy, :id => @article_id
    end

    it 'should destroy the specified article' do
      do_delete
      Article.find_by_id(@article_id).should be_nil
    end

    it 'should redirect to the admin articles list' do
      do_delete
      response.should redirect_to(admin_articles_path)
    end
  end
end
