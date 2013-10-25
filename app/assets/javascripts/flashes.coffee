$ ->

  $('p.flash').find('a.icon-close').click (e) ->
    $(e.currentTarget).parent('p.flash').fadeOut()
