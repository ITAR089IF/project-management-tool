module Account::ProfilesHelper
  def profiles_avatar(user)
    if user.with_avatar?
      image_tag url_for(user.avatar), class: 'is-rounded'
    else
      image_tag "https://bulma.io/images/placeholders/128x128.png", class: 'is-rounded'
    end
  end
end
