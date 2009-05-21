require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. spec_helper]))

describe 'articles/index.html.haml' do
  before :each do
    assigns[:article] = @article = Article.generate!(:title => 'A Day in the Life', :content => 'Just a bunch of boring, really.')
  end
  
  def do_render
    render 'articles/index.html.haml'
  end
  
  it 'should include the article title' do
    do_render
    response.should have_text(Regexp.new(Regexp.escape(@article.title)))
  end
  
  it 'should include the article content' do
    do_render
    response.should have_text(Regexp.new(Regexp.escape(@article.content)))
  end
  
  it 'should not error if the article is nil' do
    assigns[:article] = nil
    do_render
  end
end
