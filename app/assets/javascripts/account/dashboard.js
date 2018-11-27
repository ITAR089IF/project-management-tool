$( document ).on('turbolinks:load', function() {
  $('ul.tasks-list').each(function(){
    var list_length = $(this).find('li').length;
    if( list_length > 2){
      $('li', this).eq(1).nextAll().hide().addClass('toggleable');
      $(this).append('<p class="more">Show more</p>');
    }
  });
   $('ul.tasks-list').on('click','.more', function(){
     if( $(this).hasClass('less') ){
      $(this).text('Show more').removeClass('less');
    }else{
      $(this).text('Show less').addClass('less');
    }
    $(this).siblings('li.toggleable').slideToggle();
  });

  $('.date-button').click(function(){
    date = $(this).data("date");
    $('.task_form').find('.date').val(date)
  });

  // function check_project(date) {
  //   date = date
  //   $('#project_field').parent().hide();
  //   projects = $('#project_field').html();
  //   $('#workspace_field').change(function(e){
  //     workspace = $('#workspace_field :selected').text();
  //     options = $(projects).filter('optgroup[label=' + workspace + ']').html();
  //     $('#project_field').html(options);
  //     $('#project_field').parent().show();
  //     $('#date_field').val(date)
  //   });
  // };
});
