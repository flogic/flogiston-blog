require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. spec_helper]))

describe 'admin/index.html.haml' do
  def do_render
    render 'admin/index.html.haml'
  end
  
  it 'should link to the admin articles index' do
    do_render
    response.should have_tag('a[href=?]', admin_articles_path)
  end
end
