class Tag < ActiveRecord::Base
  attr_accessible :name
  has_many :bundles
  has_many :bookmarks, :through => :bundles    

  validates :name, :presence => true,
                  :length   => { :maximum => 50 }

  #TODO add a unique constraint to name. we want each tag name to be stored only once

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

end
