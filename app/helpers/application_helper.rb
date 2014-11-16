module ApplicationHelper

  def link_to_add_products(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    products = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_products", data: {id: id, products: products.gsub("\n", "")})
  end

  def avatar_url(user)
    default_url = "#{root_url}images/guest.png"
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=50d=#{CGI.escape(default_url)}"
  end

end
