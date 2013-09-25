#= require jquery
#= require jquery_ujs
#= require foundation
#= require jquery.fancybox.pack
#= require_tree .

$ ->
  $(document).foundation('orbit', {
    slide_number: false,
    bullets: false,
    timer: false
  })

  $(document).foundation()

  $('.fancybox').fancybox()
