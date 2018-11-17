jQuery(document).ready(function () {
  size_li = $(".task-list #myList li").length;
  x = 2;
  $('.task-list #myList li:lt('+x+')').show();
  $(".task-list button.show").click(function () {
      x= size_li;
      $('.task-list #myList li:lt('+x+')').show();
  });
});
