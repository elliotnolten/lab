bg = new BackgroundLayer backgroundColor: "#f2f2f2"

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
	fontFamily: "Roboto Condensed"
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
	fontFamily: "Roboto Condensed"
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
label.states.add
	edit:
		scale: 0.8
		y: 0
	done:
		scale: 1
		y: (info.height - 48) / 2

input.states.add
	edit:
		opacity: 1
	done:
		opacity: 0

edit = false

value.onClick ->
	print "edit"
	if !edit
		input.states.next("edit")
		label.states.next("edit")
		value.text = "done"
		edit = true
	else
		input.states.next("done")
		label.states.next("done")
		value.text = input.text
		edit = false
	value.maxX = info.maxX - 48
