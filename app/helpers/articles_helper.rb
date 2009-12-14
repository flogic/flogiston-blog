module ArticlesHelper
  def format_text(text)
    return '' if text.nil?
    RDiscount.new(text).to_html
  end
  
  def custom_form_fields
    []
  end
end
