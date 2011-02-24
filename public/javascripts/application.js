$(function() {
  $("#bookmarks th a, #bookmarks .pagination a, #tags th a, #tags .pagination a").live("click", function() {
    $.getScript(this.href);
    return false;
  });
  $("#bookmarks_search, #tags_search").submit(function() {
    $.get(this.action, $(this).serialize(), null, "script");
    return false;
  });  
  
  $(".new_bookmark, .edit_bookmark").submit(function() {
    var tags = $("#tag_list").val().split(" ");
	  $.each(tags, function(index) {
			  var tag = tags[index];
        if(tag != "") {
          $('<input type="hidden" name="bookmark[tags_attributes][' + index + '][name]" value="' + tag + '"/>').insertAfter('#tag_list');
        }
		});
    return true;
  });    
  
});
