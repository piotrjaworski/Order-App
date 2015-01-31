$ ->
  if $("#order-list").length > 0
    setInterval (->
      $.getScript window.location.pathname, (data, textStatus, jqxhr) ->
    ), 2000
