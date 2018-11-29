require "rails_helper"

RSpec.describe ContactsMailer, type: :mailer do
  let!(:contact) { create(:contact) }
  let!(:admin) { create(:user, role: 'admin') }

  describe "Contact us form" do
    it 'job is created' do
      ActiveJob::Base.queue_adapter = :test
      expect {
        ContactsMailer.contact_us_form(contact).deliver_later
      }.to have_enqueued_job.on_queue('mailers')
    end

    it 'email is sent' do
      expect {
        perform_enqueued_jobs do
          ContactsMailer.contact_us_form(contact).deliver_later
        end
      }.to change { Devise.mailer.deliveries.size }.by(1)
    end

    it 'email is sent to the admins' do
      perform_enqueued_jobs do
        ContactsMailer.contact_us_form(contact).deliver_later
      end
      mail = Devise.mailer.deliveries.last
      expect(mail.to[0]).to eq admin.email
    end

    it 'email subject' do
      perform_enqueued_jobs do
        ContactsMailer.contact_us_form(contact).deliver_later
      end
      mail = Devise.mailer.deliveries.last
      expect(mail.subject).to eql("Contact Form")
    end
  end
end
