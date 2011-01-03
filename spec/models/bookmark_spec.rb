require 'spec_helper'

describe Bookmark do

  before(:each) do
    @attr = { :title => "my bookmark", :url => "http://interwebs.com", :tags => "stuff things", 
      :notes => "bleh" } 
  end

  it "should allow much larger url column size"
  
  it "should create a new instance given valid attributes" do
    Bookmark.create!(@attr)
  end

  it "should require a title" do
    bookmark = Bookmark.new(@attr.merge(:title => ""))
    bookmark.should_not be_valid
  end

  it "should require a url" do
    bookmark = Bookmark.new(@attr.merge(:url => ""))
    bookmark.should_not be_valid
  end

end
