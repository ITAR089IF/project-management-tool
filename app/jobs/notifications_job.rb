class NotificationsJob < ApplicationJob
  queue_as :default

  def perform(user)
    NotificationsChannel.broadcast_to user, count: user.messages.unreaded.count
  end
end
