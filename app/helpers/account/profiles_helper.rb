module Account::ProfilesHelper
  def profile_avatar(user)
    image_tag((user.with_avatar? ? url_for(user.avatar) : "128x128.png"),  class: 'is-rounded')
  end

  def profile_initials(user)
    if user.with_avatar?
      image_tag(user.avatar)
    else
      user.user_initials
    end
  end
end
