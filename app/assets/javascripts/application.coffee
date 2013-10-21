#= require jquery
#= require jquery_ujs
#= require foundation
#= require jquery.fancybox.pack
#= require jquery_nested_form
#= require_tree .

$ ->
  $(document).foundation('orbit', {
    bullets: false,
    pause_on_hover: true,
    resume_on_mouseout: true
  })

  $(document).foundation()

  $('.fancybox').fancybox()
