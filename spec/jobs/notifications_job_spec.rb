require 'rails_helper'

RSpec.describe NotificationsJob, type: :job do
  let!(:user) { create(:user) }

  describe "#perform_later" do
    it "get a user" do
      ActiveJob::Base.queue_adapter = :test
      expect { NotificationsJob.perform_later(user) }.to have_enqueued_job
    end

    it "check if broadcast calls" do
      expect(NotificationsChannel).to receive(:broadcast_to)
      NotificationsJob.perform_now(user)
    end
  end
end
