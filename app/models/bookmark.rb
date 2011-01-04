class Bookmark < ActiveRecord::Base
  attr_accessible :title, :url, :tags, :notes

  validates :title, :presence => true,
                  :length   => { :maximum => 50 }
  validates :url, :presence => true,
                  :length   => { :maximum => 255 }


  def self.search(search)
    if search
      where('title LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

end
