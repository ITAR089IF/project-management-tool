class UsersMailer < ApplicationMailer
  default template_path: 'mailers/users'

  def send_new_user_message(current_user)
    @user = current_user
    email_admins = User.admins.pluck(:email)
    if email_admins.any?
      mail(
        to: email_admins,
        subject: "New user sign up"
      )
    end
  end
end
