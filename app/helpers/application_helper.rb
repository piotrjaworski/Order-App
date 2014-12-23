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

  def link_to_function(name, *args, &block)
     html_options = args.extract_options!.symbolize_keys

     function = block_given? ? update_page(&block) : args[0] || ''
     onclick = "#{"#{html_options[:onclick]}; " if html_options[:onclick]}#{function}; return false;"
     href = html_options[:href] || '#'

     content_tag(:a, name, html_options.merge(:href => href, :onclick => onclick))
  end

  def link_to_submit(*args, &block)
    link_to_function (block_given? ? capture(&block) : args[0]), "$(this).closest('form').submit()", args.extract_options!
  end

  def link_to_active_li(text, url, html_options = {})
    active = "active" if current_page?(url)
    content_tag :li, class: active do
      link_to text, url, html_options
    end
  end

end
