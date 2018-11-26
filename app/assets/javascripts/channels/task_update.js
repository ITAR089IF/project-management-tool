jQuery(document).on('turbolinks:load', function() {
   App.taskUpdate = App.cable.subscriptions.create( { channel: "TaskUpdateChannel", id: $('[data-project-id]').data('project-id') }, {
     received: function(data) {
      $('.task_' + data.task_id).replaceWith(data.task);
    }
  });
});
