{TextLayer} = require 'TextLayer'

# Load Roboto font
Utils.insertCSS "@import url(https://fonts.googleapis.com/css?family=Roboto:300);"

# Framer defaults
Framer.Defaults.Animation =
	curve: "spring(800,60,10)"
# pd is pixel density
p = 1

# Detect device type
if Utils.isPhone()
	p = 2

bg = new BackgroundLayer backgroundColor: "#fafafa"

infoH = 56 * p

info = new Layer
	width: 375 * p, height: infoH, y: 200
	backgroundColor: "#fff"
info.style =
	"border-bottom": "1px solid #c6c6c6"

info.centerX()

label = new TextLayer
	parent: info
	width: info.width / 3 - (24 * p), height: info.height
	backgroundColor: null
	text: "Address"
	x: 24 * p
	fontFamily: "Roboto", fontWeight: 300, fontSize: 16 * p, lineHeight: info.height / (16 * p), color: "#183053"

edit = new TextLayer
	parent: info, backgroundColor: null
	width: (info.width * 2) / 3 - 48 * p, height: 16 * 5 * p
	x: info.width / 3
	clip: true
	text: "Tweede Kostverlorenkade 128"
	contentEditable: true
	
edit.style =
	"color": "#999"
	"font-size": 16 * p + "px"
	"font-family": "Roboto"
	"font-weight": "300"
	"line-height": "1.5"
	"text-align": "right"
	"padding-top": 16 * p + "px"
	"padding-bottom": 16 * p + "px"
	"padding-left": 24 * p + "px"
	"border-left": "1px solid #fff"
	"overflow": "hidden"
	"text-overflow": "clip"
	"white-space": "normal"
	"word-wrap": "break-word"

icEdit = new Layer
	parent: info, backgroundColor: "#fff"
	width: 48 * p, height: info.height
	maxX: info.width
icon = new Layer
	parent: icEdit
	image: "images/ic_edit.pdf"
	size: 16 * p
	y: 20 * p
icon.centerX()

info.height = edit.height

info.states.add
	blur: height: 16 * 5 * p
	focus: height: infoH
info.states.switchInstant

edit.states.add
	blur:
		height: (16 * 5 - 2) * p
		backgroundColor: "#fff"
	focus:
		height: infoH - p
		backgroundColor: "#f2f2f2"
edit.states.switchInstant("blur")

icEdit.states.add
	blur:
		height: (16 * 5 - 2) * p
		backgroundColor: "#fff"
	focus:
		height: infoH - p
		backgroundColor: "#f2f2f2"
icEdit.states.switchInstant("blur")

editState = false

toggleEdit = () ->
	if not editState
		editState = true

		edit.style =
			"text-align": "left"
			"border-left": "1px solid #c6c6c6"
			"white-space": "nowrap"
		edit.states.next("focus")
		info.states.next("focus")
		icEdit.states.next("focus")
		icon.image = "images/ic_delete.pdf"
	else
		editState = false

		edit.style =
			"text-align": "right"
			"border-left": "1px solid #fff"
			"white-space": "normal"
		edit.states.next("blur")
		info.states.next("blur")
		icEdit.states.next("blur")
		icon.image = "images/ic_edit.pdf"

info.onClick ->
	toggleEdit()