class ContactsMailer < ApplicationMailer
  default template_path: 'mailers/contacts'

  def contact_us_form(contact)
    @contact = contact
    email_admins = User.admins.pluck(:email)
    if email_admins.any?
      mail(
        to: email_admins,
        subject: "Contact Form"
      )
    end
  end
end
