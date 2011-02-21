class Bundle < ActiveRecord::Base
  attr_accessible :bookmark_id, :tag_id

  belongs_to :bookmark
  belongs_to :tag  

  validates :bookmark, :presence => true
  validates :tag, :presence => true
end
