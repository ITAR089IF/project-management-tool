$( document ).on('turbolinks:load', function() {
  $('.modal-background').click(function(){
    $('.modal').removeClass('is-active');
  });
  $('.close').click(function(e){
    $('.modal').removeClass('is-active');
  });
});
