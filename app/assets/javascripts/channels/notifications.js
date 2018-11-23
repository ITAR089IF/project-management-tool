jQuery(document).on('turbolinks:load', function() {

  App.notifications = App.cable.subscriptions.create("NotificationsChannel", {

    connected: function() {
      
    },
    disconnected: function() {

    },
    received: function(data) {
      console.log(data["count"]);
      console.log(data);
      var badge = $("#my_badge").addClass("badge is-badge-small is-badge-outlined").attr("data-badge", data["count"]);
    }
  });
});

// function updateUserNotificationsCount(count) {
//   var badge = $("#my_badge").addClass("badge is-badge-small is-badge-outlined").attr("data-badge", count);
// }