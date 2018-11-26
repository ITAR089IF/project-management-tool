jQuery(document).on('turbolinks:load', function() {

  App.notifications = App.cable.subscriptions.create("NotificationsChannel", {

    connected: function() {
    },

    disconnected: function() {
    },

    received: function(data) {
      $("#notifications_counter").addClass("badge is-badge-small is-badge-outlined").attr("data-badge", data["count"]);
    }
  });
});