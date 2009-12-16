require File.expand_path(File.join(File.dirname(__FILE__), %w[.. spec_helper]))

describe AdminHelper do
  it 'should have a means of getting admin sections' do
    helper.should respond_to(:admin_sections)
  end
  
  describe 'admin sections' do
    it "should start as an array including 'articles'" do
      helper.admin_sections.should include('articles')
    end
  end
  
  it 'should have a means of registering sections' do
    AdminHelper.should respond_to(:register_section)
  end
  
  describe 'registering sections' do
    it 'should accept a section name' do
      lambda { AdminHelper.register_section('something') }.should_not raise_error(ArgumentError)
    end
    
    it 'should require a section name' do
      lambda { AdminHelper.register_section }.should raise_error(ArgumentError)
    end
    
    it 'should add the given section to the admin sections' do
      s = 'someawesomesect'
      AdminHelper.register_section(s)
      helper.admin_sections.last.should == s
    end
    
    it 'should not remove any already-set admin sections' do
      sections = helper.admin_sections.dup
      s = 'somethingelse'
      AdminHelper.register_section(s)
      helper.admin_sections.should == (sections + [s])
    end
    
    it 'should ignore any already-present admin section' do
      # dealing with reloading and dev mode, mostly
      sections = helper.admin_sections.dup
      s = sections.last
      AdminHelper.register_section(s)
      helper.admin_sections.should == sections
    end
  end
end
