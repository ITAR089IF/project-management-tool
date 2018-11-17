class UsersMailer < ApplicationMailer
  default template_path: 'mailers/users'

  def send_new_user_message(current_user)
    @user = current_user
    email_admins = User.admins.pluck(:email)
    mail(
      to: email_admins,
      subject: "New user registration"
    )
  end
end
