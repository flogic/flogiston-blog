class Article < ActiveRecord::Base
  
  default_scope :order => 'published_at DESC'
  
  class << self
    def latest
      first
    end
  end
  
  private
  
  def default_publication_time
    update_attributes(:published_at => created_at) unless published_at
  end
  after_save :default_publication_time
end
