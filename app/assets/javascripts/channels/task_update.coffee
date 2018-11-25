$(() ->
  App.task_update = App.cable.subscriptions.create { channel: "TaskUpdateChannel", id: $('[data-project-id]').data('project-id'); },
    received: (data) ->
      $('.task_' + data.task_id).replaceWith(data.task);

  )
