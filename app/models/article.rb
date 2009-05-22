class Article < ActiveRecord::Base
  
  private
  
  def default_publication_time
    update_attributes(:published_at => created_at) unless published_at
  end
  after_save :default_publication_time
end
