$(function() {
  $("#bookmarks th a, #bookmarks .pagination a, #tags th a, #tags .pagination a").live("click", function() {
    $.getScript(this.href);
    return false;
  });
  $("#bookmarks_search, #tags_search").submit(function() {
    $.get(this.action, $(this).serialize(), null, "script");
    return false;
  });  
});
