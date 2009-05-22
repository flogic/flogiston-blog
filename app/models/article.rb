class Article < ActiveRecord::Base
  class << self
    def latest
      find(:first, :order => 'published_at DESC')
    end
  end
  
  private
  
  def default_publication_time
    update_attributes(:published_at => created_at) unless published_at
  end
  after_save :default_publication_time
end
