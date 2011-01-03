class Bookmark < ActiveRecord::Base
  attr_accessible :title, :url, :tags, :notes

  validates :title, :presence => true,
                  :length   => { :maximum => 50 }
  validates :url, :presence => true,
                  :length   => { :maximum => 255 }

end
