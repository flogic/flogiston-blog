require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. spec_helper]))

describe 'articles/index.html.haml' do
  before :each do
    assigns[:articles] = @articles = Array.new(10) { Article.generate!(:title => 'A Day in the Life', :content => 'Just a bunch of boring, really.') }
    @title   = @articles[0].title
    @content = @articles[0].content
  end
  
  def do_render
    render 'articles/index.html.haml'
  end
  
  it 'should include the article titles' do
    do_render
    response.should have_text(Regexp.new(Regexp.escape(@title)))
  end
  
  it 'should include links to the articles' do
    do_render
    response.should have_tag('ul.articles') do
      with_tag('a[href*=?]', Regexp.new(Regexp.escape(articles_path + "/") + '\d+'), 10)
    end
  end
    
  it 'should not error if the article is nil' do
    assigns[:article] = nil
    do_render
  end
end
