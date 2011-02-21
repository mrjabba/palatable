class Bookmark < ActiveRecord::Base
  attr_accessible :title, :url, :notes

  has_many :bundles
  has_many :tags, :through => :bundles    

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
