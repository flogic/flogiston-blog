require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. .. spec_helper]))

describe 'admin/articles/index.html.haml' do
  before :each do
    @article = Article.generate!(:title => 'Who Is To Say?', :content => 'Nobody, really.')
    assigns[:articles] = [@article]
  end
  
  def do_render
    render 'admin/articles/index.html.haml'
  end
  
  it 'should have an articles list' do
    do_render
    response.should have_tag('table[id=?]', 'articles')
  end
  
  describe 'articles list' do
    it 'should have a row for the article' do
      do_render
      response.should have_tag('table[id=?]', 'articles') do
        with_tag('tbody') do
          with_tag('tr')
        end
      end
    end
    
    it 'should include the article title' do
      do_render
      response.should have_tag('table[id=?]', 'articles') do
        with_tag('tbody') do
          with_tag('tr', :text => Regexp.new(Regexp.escape(@article.title)))
        end
      end
    end
    
    it 'should link to the article' do
      do_render
      response.should have_tag('table[id=?]', 'articles') do
        with_tag('tbody') do
          with_tag('tr') do
            with_tag('a[href=?]', admin_article_path(@article))
          end
        end
      end
    end
    
    it 'should link to edit the article' do
      do_render
      response.should have_tag('table[id=?]', 'articles') do
        with_tag('tbody') do
          with_tag('tr') do
            with_tag('a[href=?]', edit_admin_article_path(@article))
          end
        end
      end
    end
    
    it 'should link to destroy the article' do
      do_render
      response.should have_tag('table[id=?]', 'articles') do
        with_tag('tbody') do
          with_tag('tr') do
            with_tag('a[href=?][onclick*=?]', admin_article_path(@article), 'delete')
          end
        end
      end
    end
    
    it 'should have a list item for every article' do
      other_article = Article.generate!(:title => 'Something Else', :content => 'or did I?')
      assigns[:articles] = [@article, other_article]
      
      do_render
      response.should have_tag('table[id=?]', 'articles') do
        with_tag('tbody') do
          [@article, other_article].each do |article|
            with_tag('tr') do
              with_tag('a[href=?]', admin_article_path(article))
            end
          end
        end
      end
    end
    
    it 'should have no list items if there are no articles' do
      assigns[:articles] = []
      do_render
      response.should have_tag('table[id=?]', 'articles') do
        with_tag('tbody') do
          without_tag('tr')
        end
      end
    end
  end
end
