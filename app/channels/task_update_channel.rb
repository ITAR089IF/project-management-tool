class TaskUpdateChannel < ApplicationCable::Channel
  def subscribed
    stream_from "project_#{params[:id]}"
  end
end
