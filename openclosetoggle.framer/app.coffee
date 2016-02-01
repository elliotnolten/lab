TextLayer = require "TextLayer"

open = false
i = 0
colorOn = new Color("#36c")
colorOff = new Color("#c5c2be")
OpenSans = "Open Sans"
fontSize = 27
tuatara = "#31312f"
textOn = "Open"
textOff = "Dicht"
openText = "Op het moment dat je je winkel weer opent is het voor 5 minuten niet mogelijk om je winkel weer te sluiten. Weet je zeker dat je je winkel weer wilt openen?"
closeText = "Op het moment dat je je winkel (tijdelijk) sluit is het voor 5 minuten niet mogelijk om je winkel weer open te zetten. Weet je zeker dat je je winkel weer wilt sluiten?"
timeOutText = "Je hebt zeer kort geleden deze instelling al een keer gewijzigd. Vanaf het moment van wijzigen duurt het 5 minuten voordat je je winkel weer kunt openen of sluiten... Nog even geduld!"
timeout = false
timeoutLength = 5 * 1000
print timeout
timeoutOff = () ->
	timeout = false
	print timeout

btnStyle = 
	fontFamily: "Open Sans"
	fontSize: 12
	color: "#fff"

bg = new BackgroundLayer
	backgroundColor: "#f0ede7"

container = new Layer
	width: 220, height: 200
	backgroundColor: "transparent"
	y: 200
container.centerX()

label = new TextLayer
	superLayer: container
	text: "Jouw winkel is nu"
	fontSize: fontSize
	fontFamily: OpenSans
	color: tuatara
	autoSize: true
	
toggle = new Layer
	superLayer: container
	width: 150
	height: 60
	borderRadius: 30
	backgroundColor: "#FFF"

toggle.style =
	"border": "2px solid #c5c2be"

toggle.center()

text = new TextLayer
	superLayer: toggle
	text: textOff
	autoSize: true
	fontSize: 27
	fontFamily: OpenSans
	color: "#31312f"
	lineHeight: toggle.height / 30
	x: 62

knob = new Layer
	superLayer: toggle
	width: 36
	height: 36
	borderRadius: 20
	backgroundColor: colorOff
	x: 10
	y: 10
knobOn = new Layer
	superLayer: knob
	width: knob.width
	height: knob.height
	borderRadius: knob.borderRadius
	backgroundColor: colorOn
	opacity: 0
	
mask = new Layer
	backgroundColor: "rgba(49,49,47,0.25)"
	width: Screen.width, height: Screen.height
	opacity: 0

modal = new Layer
	backgroundColor: "#fff"
	superLayer: mask
	width: 750, height: 350
	borderRadius: 8
	opacity: 0, scale: 0.9
modal.centerX()
modal.centerY(-100)
modalTxtContainer = new TextLayer
	text: openText
	superLayer: modal
	padding: 42
	fontSize: 24
	lineHeight: 1.25
	width: modal.width - 42	
	height: modal.height - 42
	color: tuatara

modalBtn = new TextLayer
	backgroundColor: "#36c"
	superLayer: modal
	fontSize: 24
	padding: 12
	autoSize: true
	borderRadius: 3
	text: "Ja, zeker"
modalBtn.style = btnStyle
modalBtn.x = 42
modalBtn.y = modal.height - 42 - modalBtn.height

cancelBtn = new TextLayer
	fontSize: 24
	autoSize: true
	color: "#36c"
	text: "Nee, toch niet"
	superLayer: modal
cancelBtn.x = modalBtn.width + 21 + 42
cancelBtn.y = modal.height - 42 - modalBtn.height + 12

# Define some animations
maskShow = new Animation
	layer: mask
	properties:
		opacity: 1
	curve: "ease-in-out"
	time: 0.2
maskHide = maskShow.reverse()

modalShow = new Animation
	layer: modal
	properties:
		opacity: 1
		scale: 1
	curve: "spring(700,50,10)"
modalHide = new Animation	
	layer: modal
	properties: 
		opacity: 0
		scale: 0.9
	curve: "ease-in-out"
	time: 0.1

toggleOpen = new Animation
	layer: toggle
	properties:
		backgroundColor: "#fff"
	time: 0.2
	curve: "ease-in-out"
toggleClose = toggleOpen.reverse()

knobOpen = new Animation
	layer: knob
	properties: 
		x: toggle.width - 36 - 14
	time: 0.2
	curve: "ease-in-out"
knobClose = knobOpen.reverse()

knobOnOpen = new Animation
	layer: knobOn
	properties: 
		opacity: 1
	time: 0.2
	curve: "ease-in-out"
knobOnClose = knobOnOpen.reverse()

textOpen = new Animation
	layer: text
	properties:
		x: 24
		color: "#31312f"
	time: 0.2
textClose = textOpen.reverse()

# When the mask is shown, show modal and ignore events on toggle
maskShow.on Events.AnimationEnd, ->
	toggle.ignoreEvents = true
	modalShow.start()

# Show the right model text when open is true or false
modalShow.on Events.AnimationStart, ->
	if not timeout
		modalBtn.text = "Ja, zeker"
		cancelBtn.opacity = 1
		if open
			modalTxtContainer.text = openText
		else
			modalTxtContainer.text = closeText
	else if timeout
		modalTxtContainer.text = timeOutText
		modalBtn.text = "Ok, sluit deze melding"
		cancelBtn.opacity = 0

# When the mask is hidden, hide modal and make events on toggle available
modalHide.on Events.AnimationEnd, ->
	toggle.ignoreEvents = false
	maskHide.start()

# When knob opens, start all consecutive "open" animations
knobOpen.on Events.AnimationStart, ->
	knobOnOpen.start()
	textOpen.start()
	toggleOpen.start()
	Utils.delay 0.1, ->
		text.text = textOn
	open = true

# When knob closes, start all consecutive "close" animations
knobClose.on Events.AnimationStart, ->
	knobOnClose.start()
	textClose.start()
	toggleClose.start()
	Utils.delay 0.1, ->
		text.text = textOff
	open = false

toggle.on Events.Click, ->
	if not timeout
		if not open
			knobOpen.start()
		else
			knobClose.start()
	
	Utils.delay 0.2, ->
		maskShow.start()

modalBtn.on Events.Click, ->
	if not timeout
		timeout = true
		print timeout
		setTimeout timeoutOff, timeoutLength
	modalHide.start()

cancelBtn.on Events.Click, ->
	modalHide.start()
	if not timeout
		Utils.delay 0.5, ->
			if open
				knobClose.start()
			else
				knobOpen.start()