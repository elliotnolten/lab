# Import file "20160710_box-office_usa-launch" (sizes and positions are scaled 1:2)
sketch = Framer.Importer.load("imported/20160710_box-office_usa-launch@2x")
# >>> Framer Fold >>>
# Sharing Info
# This info is presented in a widget when you share

Framer.Info =
	title: "TBO Landing page - US launch"
	description: "The landing page for The Box Office with a few changes especially for the US launch."
	author: "Elliot Nolten"
	twitter: "elliotnolten"

# <<< Framer Fold <<<

scroll = ScrollComponent.wrap(sketch.body)
scroll.scrollHorizontal = false
scroll.directionLock = true
# scroll.directionLockThreshold = x: 50, y: 0

lookbooks = new ScrollComponent
	parent: scroll.content
	x: 860, y: 2496 + 112
	width: Screen.width
	height: 900
	backgroundColor: "#f2f2f2"

lookbooks.contentInset =
	left: 96
	right: 96

lookbooks.directionLock = true
# lookbooks.directionLockThreshold = x: 0, y: 50

lbContent = new Layer
	parent: lookbooks.content
	image: "images/lookbooks_mobile.png"
	width: 1500, height: 900
	
lookbooks.scrollVertical = false
lookbooks.parent = scroll.content
	
showHeaderAni = new Animation
	layer: sketch.header_white
	properties: y: 0
	time: 0.3
	curve: "ease-in-out"

hideHeaderAni = showHeaderAni.reverse()

showHeader = Utils.throttle 1, ->
	showHeaderAni.start()
hideHeader = Utils.throttle 1, ->
	hideHeaderAni.start()

scroll.onMove ->
	if scroll.scrollY > 1180
		showHeader()
	else
		hideHeader()