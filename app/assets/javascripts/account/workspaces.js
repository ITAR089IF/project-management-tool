$( document ).on('turbolinks:load', function() {
  $('.modal-background').click(function(){
    $('.modal').removeClass('is-active');
  });
  $('.close').click(function(e){
    $('.modal').removeClass('is-active');
    $(e).parent().find('modal-card-title').html('');
    $(e).parent().parent().find('modal-card-body').html('');
  });
});
