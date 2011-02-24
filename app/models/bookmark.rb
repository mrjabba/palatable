class Bookmark < ActiveRecord::Base
  attr_accessible :title, :url, :notes, :tags_attributes
  before_create :associate_existing_tags_to_bookmark
  before_update :associate_existing_tags_to_bookmark

  has_many :bundles
  has_many :tags, :through => :bundles    

  accepts_nested_attributes_for :tags

  validates :title, :presence => true,
                  :length   => { :maximum => 50 }
  validates :url, :presence => true,
                  :length   => { :maximum => 255 }


  def tags_as_text
    names = []
    self.tags.each{|t| names << t.name}
    names.join(" ")
  end

  def self.search(search)
    if search
      where('title LIKE ?', "%#{search}%")
    else
      scoped
    end
  end

  private

    def associate_existing_tags_to_bookmark
      names = []
      self.tags.each {|t| names << t.name }
      names = names.uniq
      self.tags.clear
      self.bundles.clear
      names.each {|n|
        tags = Tag.where("name = ?", n )
        if tags.size > 0
          self.tags.push(tags[0])
        else
          self.tags.push(Tag.new(:name => n))
        end
      }
    end

end
