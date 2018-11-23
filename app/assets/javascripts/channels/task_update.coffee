$(() ->
  App.task_update = App.cable.subscriptions.create { channel: "TaskUpdateChannel", id: '11' },
    received: (data) ->
      console.log('hello')
  )
