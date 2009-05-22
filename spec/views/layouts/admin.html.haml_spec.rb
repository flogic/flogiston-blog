require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. spec_helper]))

describe 'layouts/admin.html.haml' do
  def do_render
    render :text => '<div id="yielded">Success</div>', :layout => 'admin'
  end
  
  it 'should wrap view content' do
    do_render
    response.should have_tag('div[id=?]', 'yielded', :text => 'Success')
  end
end
