require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. .. spec_helper]))

describe 'admin/articles/show.html.haml' do
  before :each do
    assigns[:article] = @article = Article.generate!(:title => 'A Day in the Life', :content => 'Just a bunch of boring, really.')
  end
  
  def do_render
    render 'admin/articles/show.html.haml'
  end
  
  it 'should include the article title' do
    do_render
    response.should have_text(Regexp.new(Regexp.escape(@article.title)))
  end
  
  it 'should include the article content' do
    do_render
    response.should have_text(Regexp.new(Regexp.escape(@article.content)))
  end
  
  it 'should format the article content as markdown' do
    @article.content = "
  * one
  * two
  * three
"
    do_render
    response.should have_tag('li', /one/)
  end
end
