# Setup scene
# Require jQuery
$ = require("npm").jquery

# Require TextLayer
TextLayer = require("TextLayer")

# Device
# deviceType can be either "phone" or "desktop"
x = Screen.height / 3840
Framer.DeviceView.Devices["tv"] =
	"deviceType": "phone"
	"screenWidth": 1080 * x
	"screenHeight": 3840 * x

# Set custom device
Framer.Device.deviceType = "tv"

screenMidX = Screen.width / 2
screenMidY = Screen.height / 2

darkblue = "#183051"

# Dark blue background
bg = new BackgroundLayer backgroundColor: darkblue

# Insert Roboto Condensed font
Utils.insertCSS("@import url(https://fonts.googleapis.com/css?family=Roboto+Condensed:100);")
Utils.insertCSS("body {-webkit-font-smoothing: antialiased; -moz-osx-font-smoothing: grayscale;}")

# Store image
store = new Layer
	width: Screen.width, height: Screen.height
	image: "images/map_amsterdam.png"
storeGrad = new Layer
	width: store.width, height: store.height / 4, maxY: store.maxY
storeGrad.style.background = "-webkit-linear-gradient(top, transparent 0%, #183051 100%)"
	

# Store name
storeName = new TextLayer
	text: "AMSTERDAM"
	fontFamily: "Roboto Condensed"
	color: "#fff"
	fontSize: 120 * x
	fontWeight: 100
	autoSize: true
	x: 70 * x, y: 1640 * x

# Sales rotation
# springemp = "cubic-bezier(.75,.01,.25,1)"
# 
# style =
# 	preserve3d: 
# 		"-webkit-transform-style": "preserve-3d"
# 		
# 	backfaceVisible: 
# 		"-webkit-backface-visibility": "visible"
# 		
# 	axisLine: 
# 		lineHeight: "40px"
# 		fontSize: "20px"
# count = 6
# cycles = 8
# imgSrc = ["images/shoes.png","images/racecase.png","images/suit.png"]
# 
# tiles = new Layer
# 	width: Screen.width, height: Screen.height / 2, clip: true, backgroundColor: null
# tiles.centerX()
# 
# for i in [0...count]
# 	tile = new Layer
# 		parent: tiles
# 		backgroundColor: "white"
# 		borderRadius: 8 * x, y: 262 * x
# 		width: 940 * x, height: 1298 * x
# 		originY: count / 2
# 		rotationZ: 360 / count * i
# 	tile.centerX()
# 	tile.style = style.preserve3d
# 		
# 
# 	tile.animate
# 		properties: 
# 			rotationZ: 360 / count * (i + 1)
# 		repeat: count * cycles
# 		curve: springemp
# 		delay: 1

# Sales blocks
container = new Layer
	image: "images/container.png"
	width: 940 * x, height: 1224 * x
	y: 326 * x
	scale: 1
	originY: 1
container.centerX()

container2 = container.copy()


# Fade slide down
# container2.y = (-326 - 940) * x
# container.animate
# 	properties:
# 		opacity: 0
# 		scale: 0.8
# 	delay: 1
# 	curve: "ease-in-out"
# 	time: 0.4
# 
# container.onAnimationStart ->
# 	container2.animate
# 		properties:
# 			y: 326 * x
# 		curve: "cubic-bezier(.75,.01,.25,1)"

# Rotate fade-scale-in
container.originY = 2
container2.opacity = 0
container2.scale = 0.8

container.animate
	properties:
		rotationZ: 90
		opacity: 0
		scale: 0.8
	curve: "cubic-bezier(.75,.01,.25,1)"
	time: 1
	delay: 1

container2.animate
	properties:
		opacity: 1
		scale: 1
	curve: "cubic-bezier(0,.67,.56,.98)"
	time: 0.5
	delay: 1.5