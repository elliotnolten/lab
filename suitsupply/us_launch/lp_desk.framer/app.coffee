# Import file "20160710_box-office_usa-launch"
desk = Framer.Importer.load("imported/20160710_box-office_usa-launch@1x")
# >>> Framer Fold >>>
# Sharing Info
# This info is presented in a widget when you share

Framer.Info =
	title: "TBO Landing page - US launch"
	description: "The landing page for The Box Office with a few changes especially for the US launch."
	author: "Elliot Nolten"
	twitter: "elliotnolten"

# <<< Framer Fold <<<

scroll = ScrollComponent.wrap(desk.body)
scroll.scrollHorizontal = false

showHeaderAni = new Animation
	layer: desk.header_white
	properties: y: 0
	time: 0.3
	curve: "ease-in-out"

hideHeaderAni = showHeaderAni.reverse()

showHeader = Utils.throttle 1, ->
	showHeaderAni.start()
hideHeader = Utils.throttle 1, ->
	hideHeaderAni.start()

scroll.onMove ->
	if scroll.scrollY > 430
		showHeader()
	else
		hideHeader()
		