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

video = new Layer
	width: Screen.width, height: Screen.height, opacity: 0
close = new Layer
	parent: video, width: video.width, height: video.height
embed = new Layer
	width: 1440, height: 810
	parent: video
	html: '<iframe width="1440" height="810" src="https://www.youtube.com/embed/ETOgrbl3FrY" frameborder="0" allowfullscreen></iframe>'
embed.center()
video.sendToBack()

showVideo = new Animation
	layer: video
	properties: opacity: 1
	time: 0.4
	curve: "ease-in-out"

hideVideo = showVideo.reverse()

showVideo.onAnimationStart ->
	video.bringToFront()
hideVideo.onAnimationStart ->
	video.sendToBack()

desk.playBtn.onClick ->
	showVideo.start()
desk.headerPlayBtn.onClick ->
	showVideo.start()

close.onClick ->
	hideVideo.start()