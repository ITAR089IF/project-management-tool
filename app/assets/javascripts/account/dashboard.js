jQuery(document).ready(function () {
  size_li = $("#myList li").length;
  x = 2;
  $('#myList li:lt('+x+')').show();
  $("button").click(function () {
      x= size_li;
      $('#myList li:lt('+x+')').show();
  });
});
