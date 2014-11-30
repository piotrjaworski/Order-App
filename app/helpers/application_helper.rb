module ApplicationHelper

  def link_to_add_products(name, f, association, css_class)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    products = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: css_class, data: {id: id, products: products.gsub("\n", "")})
  end

  def avatar_url(user)
    if user.photo
      "http://graph.facebook.com/" + "#{user.photo}" + "/picture?type=large"
    else
      default_url = "#{root_url}images/guest.png"
      gravatar_id = Digest::MD5::hexdigest(user.email).downcase
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=100d=#{CGI.escape(default_url)}"
    end
  end

end
