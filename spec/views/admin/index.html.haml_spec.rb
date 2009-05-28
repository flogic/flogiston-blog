require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. spec_helper]))

describe 'admin/index.html.haml' do
  def do_render
    render 'admin/index.html.haml'
  end
  
  it 'should exist' do
    do_render
  end
end
