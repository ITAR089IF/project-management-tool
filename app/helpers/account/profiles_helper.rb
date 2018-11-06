module Account::ProfilesHelper
  def profiles_avatar
    if current_user.avatar.attached?
      image_tag url_for(current_user.avatar), class: 'is-rounded'
    else
      image_tag "https://bulma.io/images/placeholders/128x128.png", class: 'is-rounded'
    end
  end
end
