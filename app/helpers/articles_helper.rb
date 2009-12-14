module ArticlesHelper
  def format_text(text)
    return '' if text.nil?
    RDiscount.new(text).to_html
  end
  
  def self.register_field(field)
    const_set(:CUSTOM_FORM_FIELDS, []) unless const_defined?(:CUSTOM_FORM_FIELDS)
    CUSTOM_FORM_FIELDS.push field if field
  end
  
  def custom_form_fields
    CUSTOM_FORM_FIELDS
  end
  
  register_field(nil)
end
