$(document).on('turbolinks:load', function() {
  Sortable.create(all_tasks, {
    handle: '.glyphicon-move',
    animation: 150,
    onEnd: function(evt) {
      var moveOption = '';
      var movePositions = 0;

      if(evt.oldIndex > evt.newIndex) {
        moveOption = 'up';
        movePositions = evt.oldIndex - evt.newIndex;
      } else if(evt.oldIndex < evt.newIndex)  {
        moveOption = 'down';
        movePositions = evt.newIndex + evt.oldIndex;
      }
      $.ajax({
        type: "PATCH",
        url: Routes.move_account_project_task_path($(evt.item).data('project-id'), $(evt.item).data('task-id')),
        data: {
          move: {
            move_option: moveOption,
            move_positions: movePositions
          }
        }
      });
    }
  });
});
