module UsersHelper
  def gravatar_for(user, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar = 
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    if user.avatar?
      image_tag(user.avatar, alt: user.name, class: "gravatar", size: 50)
    else
      image_tag('vsu_logo5.png', alt: user.name, class: "gravatar")
    end
    #image_tag('vsu_logo5.png', alt: user.name, class: "gravatar")
  end
end
