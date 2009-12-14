require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. .. spec_helper]))

describe 'admin/articles/new.html.haml' do
  before :each do
    assigns[:article] = @article = Article.new
    template.stubs(:custom_form_fields).returns([])
  end
  
  def do_render
    render 'admin/articles/new.html.haml'
  end
  
  it 'should include a link to open the markdown syntax guide on a new page' do
    do_render
    response.should have_tag('a[href=?][target=?]', 'http://daringfireball.net/projects/markdown/basics', '_blank')
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
    
    it 'should be multipart' do
      do_render
      response.should have_tag('form[id=?][enctype=?]', 'new_article', 'multipart/form-data')
    end
    
    it 'should have a title input' do
      do_render
      response.should have_tag('form[id=?]', 'new_article') do
        with_tag('input[type=?][name=?]', 'text', 'article[title]')
      end
    end
    
    # I'd rather do this really behaviorally, but that would seem to require making dummy files
    # and that's just a pain
    it 'should ask for custom form fields' do
      template.expects(:custom_form_fields).returns([])
      do_render
    end
    
    it 'should render a partial for every custom form field' do
      pending "figuring out why expects_render doesn't work"
      fields = %w[one two three]
      template.stubs(:custom_form_fields).returns(fields)
      fields.each do |field|
        template.expects_render(:partial => field)  # find a way to check passing the form-builder object
      end
      
      do_render
    end
    
    it 'should have a content input' do
      do_render
      response.should have_tag('form[id=?]', 'new_article') do
        with_tag('textarea[name=?]', 'article[content]')
      end
    end
    
    it 'should have a preview button' do
      do_render
      response.should have_tag('form[id=?]', 'new_article') do
        with_tag('input[type=?][value=?]', 'submit', 'Preview')
      end
    end
    
    it 'should have a preview input' do
      do_render
      response.should have_tag('form[id=?]', 'new_article') do
        with_tag('input[type=?][name=?]:not([value])', 'hidden', 'preview')
      end
    end
    
    describe 'preview button' do
      it 'should set the preview input to true' do
        do_render
        response.should have_tag('form[id=?]', 'new_article') do
          with_tag('input[type=?][value=?][onclick*=?][onclick*=?]', 'submit', 'Preview', 'preview', 'true')
        end
      end
    end

    it 'should have a submit button' do
      do_render
      response.should have_tag('form[id=?]', 'new_article') do
        with_tag('input[type=?]:not([value=?])', 'submit', 'Preview')
      end
    end
  end
  
  describe 'when errors are available' do
    it 'should display errors in an error region' do
      @article.errors.add_to_base("error on this page")
      do_render
      response.should have_tag('div[class=?]', 'errors', :text => /error on this page/)
    end
  end
  
  describe 'when no errors are available' do
    it 'should not display errors' do
      do_render
      response.should_not have_tag('div[class=?]', 'errors')
    end
  end
  
  describe 'preview area' do
    before :each do
        @article.content = "
 * one
 * two
"
    end

    it 'should exist if the article has content' do
      do_render
      response.should have_tag('div[id=?]', 'preview')
    end
    
    it 'should include the article content formatted with markdown' do
      do_render
      response.should have_tag('div[id=?]', 'preview') do
        with_tag('li', :text => /one/)
      end
    end

    it 'should not exist if the article content is the empty string' do
      @article.content = ''
      do_render
      response.should_not have_tag('div[id=?]', 'preview')
    end

    it 'should not exist if the article content is nil' do
      @article.content = nil
      do_render
      response.should_not have_tag('div[id=?]', 'preview')
    end

    it 'should not exist if the article content is a completely blank string' do
      @article.content = '     '
      do_render
      response.should_not have_tag('div[id=?]', 'preview')
    end
  end
end
