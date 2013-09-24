initializeMap = (latitude, longitude) ->
  latlng = new google.maps.LatLng(latitude, longitude)

  mapOptions =
    zoom: 8,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP

  map = new google.maps.Map(document.getElementById('map'), mapOptions)
  marker = new google.maps.Marker(map: map, position: latlng)

window.initializeMap = initializeMap
