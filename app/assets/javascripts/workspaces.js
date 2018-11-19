$(document).on('turbolinks:load', function() {
  $('#add_workspace').on('click', function() {
    $('.modal').show();
  });

  $('.modal-close').on('click', function() {
    $('.modal').hide();
  })
});
