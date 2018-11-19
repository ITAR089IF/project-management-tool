$( document ).on('turbolinks:load', function() {
  $('.modal-background').click(function(){
    $('.modal').removeClass('is-active');
  });
});
