require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. .. spec_helper]))

describe 'admin/articles/edit.html.haml' do
  before :each do
    assigns[:article] = @article = Article.generate!(:title => 'Who Is To Say?', :content => 'Nobody, really.')
  end
  
  def do_render
    render 'admin/articles/edit.html.haml'
  end
  
  it 'should include a link to open the markdown syntax guide on a new page' do
    do_render
    response.should have_tag('a[href=?][target=?]', 'http://daringfireball.net/projects/markdown/syntax', '_blank')
  end
  
  it 'should have an edit-article form' do
    do_render
    response.should have_tag('form[id=?]', "edit_article_#{@article.id}")
  end
  
  describe 'edit-article form' do
    it 'should use the article update action' do
      do_render
      response.should have_tag('form[id=?][action=?][method=?]', "edit_article_#{@article.id}", admin_article_path(@article), 'post') do
        with_tag('input[name=?][value=?]', '_method', 'put')
      end
    end
    
    it 'should have a title input' do
      do_render
      response.should have_tag('form[id=?]', "edit_article_#{@article.id}") do
        with_tag('input[type=?][name=?]', 'text', 'article[title]')
      end
    end
    
    it 'should populate the title input' do
      do_render
      response.should have_tag('form[id=?]', "edit_article_#{@article.id}") do
        with_tag('input[name=?][value=?]', 'article[title]', @article.title)
      end
    end
    
    it 'should have a content input' do
      do_render
      response.should have_tag('form[id=?]', "edit_article_#{@article.id}") do
        with_tag('textarea[name=?]', 'article[content]')
      end
    end
    
    it 'should populate the content input' do
      do_render
      response.should have_tag('form[id=?]', "edit_article_#{@article.id}") do
        with_tag('textarea[name=?]', 'article[content]', :text => @article.content)
      end
    end
    
    it 'should allow for submitting the form' do
      do_render
      response.should have_tag('form[id=?]', "edit_article_#{@article.id}") do
        with_tag('input[type=?]', 'submit')
      end
    end
  end
end
