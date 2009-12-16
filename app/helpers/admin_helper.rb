module AdminHelper
  def self.register_section(section)
    const_set(:ADMIN_SECTIONS, []) unless const_defined?(:ADMIN_SECTIONS)
    ADMIN_SECTIONS.push section
    ADMIN_SECTIONS.uniq!
  end

  def admin_sections
    ADMIN_SECTIONS
  end

  register_section('articles')
  
  def admin_section_links
    admin_sections.inject([]) do |links, section|
      plural = section
      single = plural.singularize
      
      links + [
        [plural,          send("admin_#{plural}_path")],
        ["new #{single}", send("new_admin_#{single}_path")]
      ]
    end
  end
end
