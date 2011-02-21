Factory.define :bookmark do |bookmark|
  bookmark.title                  "testbookmark"
  bookmark.url                 "http://foo.com"
  bookmark.notes              "this is a note"
end

Factory.define :tag do |tag|
  tag.name                  "thinger"
end
