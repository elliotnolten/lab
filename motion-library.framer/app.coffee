# Default cursor
document.body.style.cursor = "default"

# Import TextLayer Module
TextLayer = require "TextLayer"

# Create light grey background
bg = new BackgroundLayer backgroundColor: "#F0EDE7"

# Some general variables
# bol.com color palette
tuatara = "#31312f"
westar = "#dddbd5"
mariner = "#36c"
linkwater = "#d6e0f5"
white = "#fff"

# General function for pointer on hover
mouse = (layer) ->
	layer.onMouseOver -> this.style.cursor = "pointer"
	layer.onMouseOut -> this.style.cursor = "default"

# Create popin animation function
popin = (layer) ->
	layer.animate
		properties:
			scale: 1
		curve: "spring(800,30,10)"

# Create expand animation function
expand = (layer, expX, expY) ->
	layer.originX = 1
	layer.originY = 1
	layer.animate
		properties:
			width: layer.width + expX
			height: layer.height + expY
		curve: "spring(800,30,10)"

# Create popout function that loops back to popin animation
popout = (layer) ->
	layer.animate
		properties:
			scale: 0.8
			opacity: 0
		curve: "ease-in-out"
		time: 0.1
	Utils.delay 1, ->
		layer.scale = 0
		layer.opacity = 1
		popin(layer)

# Create slide in animation function
slidein = (layer) ->
	layer.animate
		properties:
			opacity: 1
			y: layer.y + 3
		curve: "ease-in-out"
		time: 0.3

# Create alert
alert = new Layer
	width: 50, height: 50, borderRadius: 25, scale: 0

alert.centerX(-1 * (alert.width * 2))
alert.centerY()

Utils.delay 1, ->
	popin(alert)
	
alert.onClick ->
	expand(this, 100, 100)

mouse(alert)

# Create dropdown
optionChosen = "Kies een land"
# Define array of options
options = ["Nederland","België","Duitsland","Frankrijk","Verenigd Koninkrijk"]
# Create selectbox
select = new TextLayer
	text: "Kies een land"
	fontFamily: "Open Sans"
	width: 200, height: 35
	fontSize: 14
	lineHeight: 1.5
	color: tuatara
	backgroundColor: white
	borderRadius: 4
	paddingLeft: 14, paddingTop: 7, paddingBottom: 7
selectBorder = new Layer
	width: select.width, height: select.height, backgroundColor: null, borderRadius: 4
	style: "border": "1px solid" + westar

# Create dropdown
option = new ScrollComponent
	y: select.height
	width: select.width, borderRadius: 4, backgroundColor: white
	style: "border": "1px solid" + westar
	opacity: 0, contentInset: top: 4, bottom: 6
option.content.style = backgroundColor: white
option.scrollHorizontal = false
option.mouseWheelEnabled = true

# Dropdown container
drpDwn = new Layer
	width: select.width, height: select.height, backgroundColor: null
drpDwn.centerX(50)
drpDwn.centerY(-0.5)
select.parent = drpDwn
option.parent = drpDwn
selectBorder.parent = drpDwn

for i in [0..(options.length - 1)]
	optionEl = new TextLayer
		parent: option.content
		width: option.width
		height: 31
		fontSize: 14
		lineHeight: 31/14
		fontFamily: "Open Sans"
		text: options[i]
		color: tuatara
		paddingLeft: 14
		backgroundColor: white
		y: 31 * i
	
	mouse(optionEl)
	
	optionEl.onClick ->
		option.opacity = 0
		option.y = select.height
		optionChosen = this.text
		select.text = optionChosen
	
	optionEl.onMouseOver ->
		this.backgroundColor = linkwater
	optionEl.onMouseOut ->
		this.backgroundColor = white

mouse(select)

select.onClick ->
	slidein(option)