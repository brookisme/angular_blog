#
# Menu Handler (same as main_app)
#
nav = $("#navbar-wrapper")
closed_nav_height = nav.height()
opened_nav_height = 300

toggle_nav  = ->
  if nav.hasClass('open')
    nav.animate({height: closed_nav_height})
    nav.removeClass('open')
  else
    nav.addClass('open')
    nav.animate({height: opened_nav_height})

jQuery ($)->
  $('.nav-toggle').click(toggle_nav)

