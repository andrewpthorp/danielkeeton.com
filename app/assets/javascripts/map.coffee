initializeMap = (latitude, longitude, link, address) ->
  latlng = new google.maps.LatLng(latitude, longitude)

  mapOptions =
    zoom: 8,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP

  map = new google.maps.Map(document.getElementById('map'), mapOptions)
  marker = new google.maps.Marker(map: map, position: latlng)

  contentString = "<div>#{address}</div><p style='margin-bottom: 1px;'><a href='#{link}' target='_blank'>View Google Maps</a></p>"
  infoWindow = new google.maps.InfoWindow({ content: contentString })

  google.maps.event.addListener marker, 'click', ->
    infoWindow.open(map, marker)


window.initializeMap = initializeMap
