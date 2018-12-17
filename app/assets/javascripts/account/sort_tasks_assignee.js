$( document ).on('turbolinks:load', function() {
  let positions = $('.tasks .level').map(function() {
    return $(this).data('task-id');
  }).get();

  $( ".sort" ).click(function() {
    var userInfo = [];
    $('.tasks .level').each(function() {
      let assigneeId = $(this).data('assignee-id');
      if (assigneeId != false) {
        userInfo.push([assigneeId, $(this).children('.level-right').children('.image').data('tooltip')]);
      }
    });

    userInfo.sort(function(firstUser, secondUser) {
      let name1 = firstUser[1].toUpperCase();
      let name2 = secondUser[1].toUpperCase();
      if (name1 < name2) {
        return -1;
      }
      if (name1 > name2) {
        return 1;
      }
      return 0;
    });

    for (let i = 0; i < userInfo.length; i++) {
      for (let j = userInfo.length-1; j > i; j--) {
        if (userInfo[i][0] == userInfo[j][0]) {
          userInfo.splice(j, 1);
        };
      };
    };

    let taskInfo = {};
    userInfo.forEach(function(user) {
      taskInfo[user[0]] = [];
    });
    taskInfo['unassigned'] = [];

    $('.tasks .level').each(function() {
      let taskId = $(this).data('task-id');
      let assigneeId = $(this).data('assignee-id');
      if (assigneeId) {
        taskInfo[assigneeId].push(taskId);
      }
      else {
        taskInfo['unassigned'].push(taskId);
      }
    });

    if ($('.sorted').length == 0) {
      $('.tasks').after('<div class="container box tasks sorted list" id ="all_tasks"></div>');

      userInfo.forEach(function(user){
        $('.sorted').append(`<div class="list" data-list-id=${user[0]}></div>`);
        $('.sorted').find(`[data-list-id=${user[0]}]`).append('<h2 class="has-text-weight-bold">'+user[1]+'</h2>');

        taskInfo[user[0]].forEach(function(taskId){
          $('.sorted').find(`[data-list-id=${user[0]}]`).append($(".unsorted").find(`[data-task-id='${taskId}']`));
        });
      });

      $('.sorted').append('<h2 class="has-text-weight-bold">Unassigned</h2>');
      taskInfo['unassigned'].forEach(function(taskId){
        $('.sorted').append($(".unsorted").find(`[data-task-id='${taskId}']`));
      });

      $('.unsorted').remove();
      dragAndDrop();
    }
    else {
      $('.sorted').after('<div class="container box tasks unsorted list" id ="all_tasks"></div>');
      positions.forEach(function(taskId){
        $('.unsorted').append($(".sorted").find(`[data-task-id='${taskId}']`));
      });

      $('.sorted').remove();
      dragAndDrop();
    };
  });
});
