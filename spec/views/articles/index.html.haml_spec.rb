require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. spec_helper]))

describe 'articles/index.html.haml' do
  def do_render
    render 'articles/index.html.haml'
  end
  
  describe 'each article' do
    before :each do
      @article = Article.generate!(:title => 'A Day in the Life', :content => 'yadda')
      assigns[:articles] = [@article]
      @title   = @article.title
      @content = @article.content
      template.stubs(:will_paginate)
    end

    it 'should include the title' do
      do_render
      response.should have_tag('li.article', Regexp.new(Regexp.escape(@title)))
    end

    it 'should include a link' do
      do_render
      response.should have_tag('li.article') do
        with_tag('a[href=?]', article_path(@article))
      end
    end
  end

  describe 'a slew of articles' do
    before :each do
      @articles = Array.new(2) { Article.generate!(:title => 'A Day in the Life', :content => 'yadda') }
      assigns[:articles] = @articles
      template.stubs(:will_paginate)
    end

    it 'should include a list of articles' do
      do_render
      response.should have_tag('ul.articles') do
        @articles.each do |article|
          response.should have_tag('li') do
            with_tag('a[href=?]', article_path(article))
          end
        end
      end
    end
  end    

  describe 'articles pagination' do
    before :each do
      assigns[:articles] = @articles = [Article.generate!(:title => 'sunday, sunday, sunday')]
    end

    it 'should use will_paginate to setup links' do
      template.expects(:will_paginate).with(@articles)
      do_render
    end

    it 'should have ' do
      @pagination_link_text = 'previous..next'
      template.stubs(:will_paginate).returns(@pagination_link_text)
      do_render
      response.should have_text(Regexp.new(@pagination_link_text))
    end
  end
end
