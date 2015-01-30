$ ->
  if $("#order-list").length
    setInterval (->
      $.getScript window.location.pathname, (data, textStatus, jqxhr) ->
    ), 2000
