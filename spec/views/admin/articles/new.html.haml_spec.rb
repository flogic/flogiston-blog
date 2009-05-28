require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. .. spec_helper]))

describe 'admin/articles/new.html.haml' do
  before :each do
    assigns[:article] = @article = Article.new
  end
  
  def do_render
    render 'admin/articles/new.html.haml'
  end
  
  it 'should include a link to open the markdown syntax guide on a new page' do
    do_render
    response.should have_tag('a[href=?][target=?]', 'http://daringfireball.net/projects/markdown/syntax', '_blank')
  end
  
  it 'should have a new-article form' do
    do_render
    response.should have_tag('form[id=?]', 'new_article')
  end
  
  describe 'new-article form' do
    it 'should use the article create action' do
      do_render
      response.should have_tag('form[id=?][action=?][method=?]', 'new_article', admin_articles_path, 'post')
    end
    
    it 'should have a title input' do
      do_render
      response.should have_tag('form[id=?]', 'new_article') do
        with_tag('input[type=?][name=?]', 'text', 'article[title]')
      end
    end
    
    it 'should have a content input' do
      do_render
      response.should have_tag('form[id=?]', 'new_article') do
        with_tag('textarea[name=?]', 'article[content]')
      end
    end
    
    it 'should allow for submitting the form' do
      do_render
      response.should have_tag('form[id=?]', 'new_article') do
        with_tag('input[type=?]', 'submit')
      end
    end
  end
end
