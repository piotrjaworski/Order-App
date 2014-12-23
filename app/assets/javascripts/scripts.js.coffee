$(document).ready ->
  $ ->
    $(".pagination a").attr "data-remote", "true"

$(document).on 'click', 'form .remove_products', (event) ->
  $(this).prev('input[type=hidden]').val('1')
  $(this).closest('fieldset').hide()
  event.preventDefault()

$(document).on 'click', 'form .add_products', (event) ->
  time = new Date().getTime()
  regexp = new RegExp($(this).data('id'), 'g')
  $(this).before($(this).data('products').replace(regexp, time))
  event.preventDefault()


