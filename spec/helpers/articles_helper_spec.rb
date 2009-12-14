require File.expand_path(File.join(File.dirname(__FILE__), %w[.. spec_helper]))

describe ArticlesHelper do
  it 'should have a means of formatting text' do
    helper.should respond_to(:format_text)
  end
  
  describe 'formatting text' do
    before :each do
      @text = 'some text'
      @formatter = RDiscount.new('blah')
    end
    
    it 'should accept text' do
      lambda { helper.format_text(@text) }.should_not raise_error(ArgumentError)
    end
    
    it 'should require text' do
      lambda { helper.format_text }.should raise_error(ArgumentError)
    end
    
    it 'should format the given text as markdown' do
      RDiscount.expects(:new).with(@text).returns(@formatter)
      helper.format_text(@text)
    end
    
    it 'should return the formatted description' do
      f = RDiscount.new(@text)
      helper.format_text(@text).should == f.to_html
    end
    
    it 'should return the empty string when given nil text' do
      helper.format_text(nil).should == ''
    end
  end
  
  it 'should have a means of getting custom form fields' do
    helper.should respond_to(:custom_form_fields)
  end
  
  describe 'custom form fields' do
    it 'should start as an empty array' do
      helper.custom_form_fields.should == []
    end
  end
  
  it 'should have a means of registering fields' do
    ArticlesHelper.should respond_to(:register_field)
  end
  
  describe 'registering fields' do
    it 'should accept a field name' do
      lambda { ArticlesHelper.register_field('something') }.should_not raise_error(ArgumentError)
    end
    
    it 'should require a field name' do
      lambda { ArticlesHelper.register_field }.should raise_error(ArgumentError)
    end
    
    it 'should add the given field to the custom fields' do
      f = 'someawesomefield'
      ArticlesHelper.register_field(f)
      helper.custom_form_fields.last.should == f
    end
    
    it 'should not remove any already-set custom fields' do
      fields = helper.custom_form_fields.dup
      f = 'somethingelse'
      ArticlesHelper.register_field(f)
      helper.custom_form_fields.should == (fields + [f])
    end
  end
end
