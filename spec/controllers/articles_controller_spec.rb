require File.expand_path(File.join(File.dirname(__FILE__), %w[.. spec_helper]))

describe ArticlesController, 'index' do
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
    
  it 'should paginate found articles in groups of 10' do
    11.times { Article.generate! }
    do_get
    assigns[:articles].size.should == 10
  end
  
  it 'should render the index template' do
    do_get
    response.should render_template('articles/index')
  end
  
  it 'should use the normal layout' do
    do_get
    response.layout.should == 'layouts/application'
  end
end

describe ArticlesController, 'show' do
  before :each do
    @article = Article.generate!
  end
  
  def do_show(id='1')
    get :show, :id => id
  end
  
  it 'should be successful' do
    do_show
    response.should be_success
  end

  it 'should make an article available to the view' do
    do_show
    assigns[:article].should be_instance_of(Article)
  end

  it 'should make the desired article available to the view' do
    @my_article = Article.generate!
    do_show(@my_article.id)
    assigns[:article].should == @my_article
  end
  
  it 'should render the show template' do
    do_show
    response.should render_template('articles/show')
  end
  
  it 'should use the normal layout' do
    do_show
    response.layout.should == 'layouts/application'
  end
end
