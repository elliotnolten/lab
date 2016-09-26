# >>> Framer Fold >>>
# Sharing Info
# This info is presented in a widget when you share

Framer.Info =
	title: ""
	description: ""
	author: "Elliot Nolten"
	twitter: ""

# <<< Framer Fold <<<

Framer.Device.deviceScale = 1

# Mapbox
{ mapboxgl } = require "npm"
# Creating a new HTML layer
# for the map to live inside of and scale
# it to fit the entire window
mapHeight = Screen.height
mapWidth = Screen.width

mapboxLayer = new Layer
mapboxLayer.ignoreEvents = false
mapboxLayer.width = mapWidth
mapboxLayer.height = mapHeight
mapboxLayer.html = "<div id='map'></div>"
mapElement = mapboxLayer.querySelector("#map")
mapElement.style.height = mapHeight + 'px'

# Set your Mapbox access token here!
mapboxgl.accessToken = 'pk.eyJ1IjoiZWxsaW90bm9sdGVuIiwiYSI6ImNpcHNhcjhuajAwMWpoem0yY2UzNHV3bmgifQ.y6ZBrTj9uTni_QFC6G-0sw'

map = new mapboxgl.Map({
	container: mapElement
	zoom: 10
	center: [-97.0115281,32.8203525]
	style: 'mapbox://styles/mapbox/streets-v9'
	hash: true
})

map.flyTo({
	center: [-100.0115281,40.8203525]
	zoom: 8
	speed: 0.2
	curve: 5
})