bg = new BackgroundLayer backgroundColor: "#f2f2f2"

# Get roboto font
Utils.insertCSS("@import url(https://fonts.googleapis.com/css?family=Roboto:300);")

Framer.Defaults.Animation =
	curve: "spring(350,30,10)"

{TextLayer} = require "TextLayer"

small = 
	"font-family": "Roboto"
	"color": "#183051"

info = new Layer
	width: Screen.width
	backgroundColor: "#fff"
	height: 112
info.style =
	"border-bottom": "1px solid #ddd"
info.centerY(-300)

label = new TextLayer
	text: "Address"
	autoSize: true
	fontSize: 32
	lineHeight: 1.5
	parent: info
	x: 48
	y: (info.height - 48) / 2
	fontWeight: 300
label.style = small

value = new TextLayer
	text: "H.J.E. Wenckebachweg"
	parent: info
	fontFamily: "Roboto"
	color: "#999"
	textAlign: "right"
	autoSize: true
	fontSize: 32
	fontWeight: 300
value.centerY()	
value.maxX = info.maxX - 48

input = new TextLayer
	text: value.text
	parent: info
	fontFamily: "Roboto"
	color: "#999"
	textAlign: "left"
	autoSize: true
	fontSize: 32
	x: 48
	contentEditable: true
	opacity: 0
	fontWeight: 300
input.centerY()

label.originX = 0

moveLabel = (layer,edit) ->
	if !edit
		layer.animate
			properties:
				scale: 0.8, y: 0
	else
		layer.animate
			properties:
				scale: 1, y: (info.height - 48) / 2

toggleInput = (layer,edit) ->
	if !edit then layer.animate properties: opacity: 1 else layer.animate properties: opacity: 0

input.states.add
	edit:
		opacity: 1
	done:
		opacity: 0

edit = false

value.onClick ->
	toggleInput(input,edit)
	moveLabel(label,edit)
	if !edit
		value.text = "done"
		value.color = "#183051"
		edit = true
	else
		value.text = input.text
		value.color = "#999"
		edit = false
	value.maxX = info.maxX - 48
