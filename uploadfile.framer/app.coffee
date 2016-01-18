TextLayer = require "TextLayer"

document.body.style.cursor = "auto"

# Create container
container = new Layer
	width: 400, height: 42, backgroundColor: null
container.center()
container.clip = false

isSuccess = Utils.randomChoice [true,false]

# create input layer
input = new TextLayer
	superLayer: container
	text: "Geen bestand geselecteerd"
	fontFamily: "Open Sans"
	color: "#c5c2be"
	fontSize: 14
	fontStyle: "italic"
	lineHeight: 1.5
	paddingLeft: 14 + 18 + 7
	paddingTop: 10
	paddingBottom: 11
	paddingRight: 14
	contentEditable: true
	width: container.width
	height: container.height

input.style =
		border: "1px solid #c5c2be"
		borderRadius: "4px"
		backgroundColor: "#fff"
input.clip = false

inputIcn = new Layer
	superLayer: container
	image: "images/xls.svg"
	width: 18, height: 14
	x: 14
inputIcn.centerY()

chooseBtn = new TextLayer
	superLayer: container
	backgroundColor: "#d6e0f5"
	fontFamily: "Open Sans"
	fontSize: 14
	text: "Kies een bestand"
	color: "#36c"
	paddingLeft: 10, paddingTop: 4, paddingRight: 7, paddingBottom: 4
	autoSize: true
	borderRadius: 3
chooseBtn.centerY()
chooseBtn.x = input.width - (chooseBtn.width + 10)

# Create submit button
submitBtn = new TextLayer
	superLayer: container
	fontFamily: "Open Sans"
	fontSize: 14
	lineHeight: 1.5
	text: "Upload bestand"
	backgroundColor: "#EAE7E1"
	color: "#94928E"
	paddingLeft: 14, paddingTop: 7, paddingRight: 14, paddingBottom: 7
	autoSize: true
	borderRadius: 3
submitBtn.y = chooseBtn.height + 42

# Create tooltip


# Create loader
loader = new Layer
	superLayer: container
	width: 15, height: 15, image: "images/loader.svg"
loader.centerY()
loader.x = container.width - (loader.width + 10)
loader.rotatationZ = 0
loader.scale = 0

# create success error icons
success = new Layer
	superLayer: container
	width: 15, height: 15, image: "images/success.svg"
success.centerY()
success.x = container.width - (loader.width + 10)
success.scale = 0

# Some Events
# Hover function
hover = (layer) ->	
	layer.on Events.MouseOver, ->
		document.body.style.cursor = "pointer"
	
	layer.on Events.MouseOut, ->
		document.body.style.cursor = "default"

hover chooseBtn
hover submitBtn

# Start everything when click choose button
chooseBtn.on Events.Click, ->
	isSuccess = Utils.randomChoice [true,false]
	success.opacity = 1
	success.scale = 0
	input.fontStyle = "normal"
	input.color = "#31312f"
	@.opacity = 0
	showLoader.start()
	loader.rotate = 0
	rotateLoader.start()
	if !isSuccess
		success.image = "images/error.svg"
		input.text = "products.doc"
	else
		success.image = "images/success.svg"
		input.text = "products.xls"

# Loader/success/error animations
showLoader = new Animation
	layer: loader
	properties: 
		scale: 1
	curve: "ease-in-out"
	time: 0.2
rotateLoader = new Animation
	layer: loader
	properties:
		rotationZ: 360
	curve: "linear"
	time: 1

# Infinite loop loader rotation
showLoader.on Events.AnimationStart, ->
	rotateLoader.start()

showSuccess = new Animation
	layer: success
	properties: 
		scale: 1
	curve: "spring(800,30,10)"
hideSuccess = showSuccess.reverse()

# when loader hides stop showSuccess
rotateLoader.on Events.AnimationEnd, ->
	showSuccess.start()
	loader.rotate = 0
	loader.scale = 0
	rotateLoader.stop()

# When file is successfully loaded, activate Upload button
showSuccess.on Events.AnimationStart, ->
	showSuccess.stop()
	if isSuccess
		submitBtn.style = 
			backgroundColor: "#36c"
			color: "#fff"
	else
		submitBtn.style =
			backgroundColor: "#EAE7E1"
			color: "#94928E"	
	
	Utils.delay 2, ->
		success.opacity = 0
		chooseBtn.opacity = 1



