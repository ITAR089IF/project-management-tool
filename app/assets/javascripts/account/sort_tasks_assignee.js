$( document ).on('turbolinks:load', function() {
  var positions = $('.tasks').children('.level').map(function() {
    return $(this).data('task-id');
  }).get();

  $( ".sort" ).click(function() {
    var userInfo = [];
    $('.tasks').children('.level').each(function() {
      var assigneeId = $(this).data('assignee-id');
      if (assigneeId != false) {
        userInfo.push([assigneeId, $(this).children('.level-right').children('.image').data('tooltip')]);
      }
    });

    userInfo.sort(function(firstUser, secondUser) {
      var name1 = firstUser[1].toUpperCase();
      var name2 = secondUser[1].toUpperCase();
      if (name1 < name2) {
        return -1;
      }
      if (name1 > name2) {
        return 1;
      }
      return 0;
    });

    i=0;
    while (i < userInfo.length-1) {
      if (userInfo[i][0] === userInfo[i+1][0] && userInfo[i][1] === userInfo[i+1][1]) {
        userInfo.splice(i+1, 1);
      };
      i+=1;
    };

    var taskInfo = {};
    userInfo.forEach(function(user) {
      taskInfo[user[0]] = [];
    });
    taskInfo['unassigned'] = [];

    $('.tasks').children('.level').each(function() {
      var taskId = $(this).data('task-id');
      var assigneeId = $(this).data('assignee-id');
      if (assigneeId) {
        taskInfo[assigneeId].push(taskId);
      }
      else {
        taskInfo['unassigned'].push(taskId);
      }
    });

    if ($('.sorted').length == 0) {
      $('.tasks').after('<div class="container box tasks sorted" id ="all_tasks"></div>');

      userInfo.forEach(function(user){
        $('.sorted').append('<h2 class="has-text-weight-bold">'+user[1]+'</h2>');
        taskInfo[user[0]].forEach(function(taskId){
          $('.sorted').append($(".unsorted").find(`[data-task-id='${taskId}']`));
        });
      });

      $('.sorted').append('<h2 class="has-text-weight-bold">Unassigned</h2>');
      taskInfo['unassigned'].forEach(function(taskId){
        $('.sorted').append($(".unsorted").find(`[data-task-id='${taskId}']`));
      });

      $('.unsorted').remove();
    }
    else {
      $('.sorted').after('<div class="container box tasks unsorted" id ="all_tasks"></div>');
      positions.forEach(function(taskId){
        $('.unsorted').append($(".sorted").find(`[data-task-id='${taskId}']`));
      });

      $('.sorted').remove();
    };
  });
});
