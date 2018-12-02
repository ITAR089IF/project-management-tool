$( document ).on('turbolinks:load', function() {
  $('.show-modal').click(function(e){
    e.preventDefault();
    $('.modal').addClass('is-active');
  });
  $('.modal-background').click(function(){
    $('.modal').removeClass('is-active');
  });
  $('.close').click(function(e){
    $('.modal').removeClass('is-active');
  });
});
