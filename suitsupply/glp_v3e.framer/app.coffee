# >>> Framer Fold >>>
# Sharing Info
# This info is presented in a widget when you share

Framer.Info =
	title: "The Garmentor Landing page version 2"
	description: ""
	author: "Elliot Nolten"
	twitter: "@elliotnolten"
	
Framer.Extras.Preloader.setLogo("http://a2.mzstatic.com/eu/r30/Purple71/v4/28/5f/9d/285f9d2a-8128-4cae-d6f5-a3a5c8632127/icon175x175.jpeg")

# <<< Framer Fold <<<

# Globals, settings and wrappers
# Orientation module from https://github.com/joshmtucker/OrientationEvents
orient = require "OrientationEvents"

screenW = Screen.width
screenH = Screen.height
x = Utils.devicePixelRatio()

# Detect device type
isFullscreen = Framer.Device.deviceType.indexOf("fullscreen") != -1
isPhone = Framer.Device.deviceType.indexOf("iphone") != -1
isTablet = Framer.Device.deviceType.indexOf("ipad") != -1

if isPhone || isTablet then isRetina = true else isRetina = false
if isFullscreen
	if Utils.isPhone() || Utils.isTablet()
		isRetina = true
	else
		isRetina = false
		
if isRetina then x = 2 else x = 1

Utils.insertCSS("@import 'https://fonts.googleapis.com/css?family=Roboto+Condensed:400|Roboto:300,700';")

bg = new BackgroundLayer backgroundColor: "#f2f2f2"
Framer.Defaults.Animation =
	curve: "spring(200,20,10)"

site = new PageComponent
	width: screenW, height: screenH
site.scrollHorizontal = false
site.scrollVertical = false
site.mouseWheelEnabled = isFullscreen

# Sections
sections = [
	{
		title: ""
		content: "Our Garmentors are trained specialists to assist you in finding the perfect fit for your suit, jacket or trousers at your home or office."
		name: "intro"
		icon: ""
	}
	{
		title: "Find a Garmentor"
		content: "Download the Suitsupply app to find out which Garmentor is nearby. Schedule a fitting session on-demand."
		name: "usp1"
	}
	{
		title: "Have it tailored"
		content: "Our Garmentor checks your fit, pins your alterations and takes your item to have it tailored."
		name: "usp2"
	}
	{
		title: "Get it delivered"
		content: "Your tailored item will be delivered at your doorstep within a few days.<br><br>The fitting session, pick-up and delivery are free of charge. Pay for alterations on site."
		name: "usp3"
	}
]

verticalSections =
	top: { top: 0, bottom: 0.5 * screenH }
	middle: { top: 0.5 * screenH, bottom: 0.75 * screenH}
	bottom: {top: 0.75 * screenH, bottom: screenH}

verticalParts = new Layer width: screenW, height: screenH, backgroundColor: null
verticalParts.bringToFront()

for i,s of verticalSections
	section = new Layer width: verticalParts.width, height: s.bottom - s.top, y: s.top, backgroundColor: null
# 	section.style = "border-bottom": "#{x}px solid rgba(255,255,255,0.5)"

# Skyline
city = new Layer width: screenW, height: screenH, backgroundColor: null, parent: site.content

sky = new Layer
	parent: city
	width: screenW * sections.length * 0.5, height: screenH, x: -screenW / 2
	image: "images/sky.png"

pageOverlay = new Layer
	parent: city
	width: Screen.width, height: Screen.height, backgroundColor: null
pageOverlay.style = "background": "linear-gradient(to bottom, rgba(24,48,81,0.6), rgba(24,48,81,0))"

if isFullscreen
	sky.width = screenW * 2

skyline = new Layer
	parent: city
	width: sky.width * 1.5
	height: screenH
	x: -screenW / 2, backgroundColor: null
# 	
buildings = new Layer
	parent: skyline
	width: skyline.width, height: skyline.width / 1500 * 352
	image: "images/ny.png"
	y: Align.bottom

if isFullscreen then buildings.y = Align.bottom(50 * x)

# List of garmentors
garmentors = [
	{ name: "benjamin", eta: 22 }
	{ name: "you"}
	{ name: "sebastiaan", eta: 24 }
]
allGarmentors = []
allGarY = []
allGarHeight = []
garTop = verticalSections.middle.top - 0 * x
garBottom = buildings.minY + 40 * x

for i,gar of garmentors
	
	deviation = Utils.randomNumber(-0.05,0.05)
	xPos = (skyline.width - 360) / garmentors.length * i + 360
	yPos = Utils.randomNumber(garTop,garBottom)
	
	garmentor = new Layer
		parent: skyline
		size: 34 * x
		x: 100 * x * i + 500, y: yPos
		backgroundColor: null
	
	avatar = new Layer
		parent: garmentor
		image: "images/garmentors/#{gar.name}.png"
		width: garmentor.width, height: garmentor.height
		opacity: 0
		scale: 0.5
		
	ring = new Layer
		parent: avatar
		width: garmentor.width + 12 * x, height: garmentor.height + 12 * x
		borderRadius: (garmentor.width + 12 * x) / 2, backgroundColor: null
	ring.style =
		"border": 3 * x + "px solid #183051"
	ring.center()
	
	eta = new Layer
		parent: garmentor, html: "ETA #{gar.eta} min", backgroundColor: null, height: 20 * x, y: -28 * x, opacity: 0
	eta.centerX()
	eta.style = 
		"text-align": "center"
		"font-size": 14 * x + "px"
		"line-height": "1.5"
		"font-family": "Roboto"
		"font-weight": "300"
	
	avatar.scale = Utils.randomNumber(0.75,1.25)
	
	if gar.name == "you"
		eta.html = "you"
		eta.scale = 1
		ring.opacity = 0
		garmentor.y = ( garBottom + garTop ) / 2
	
	pointer = new Layer
		parent: garmentor
		width: x, height: Screen.height - garmentor.height + 20 * x, y: garmentor.height + 20 * x
		backgroundColor: "rgba(255,255,255,0.5)"
	pointer.centerX()
	pointer.scaleY = 0
	
	allGarmentors.push(garmentor)
	allGarY.push(yPos)

buildings.bringToFront()

# Show garmentors
showGarmentors = (layer,i) ->
	avatar = layer.children[0]
	pointer = layer.children[2]
	delay = 0.2

	pointer.animate
		properties: scaleY: 1
		curve: "ease-in-out"
		time: 0.3
		delay: delay * i
	
	avatar.animate
		properties:
			scale: 1
			opacity: 1
		curve: "spring(200,20,10)"
		delay: (0.3 + delay) * i

hideGarmentors = (layer,i) ->
	avatar = layer.children[0]
	pointer = layer.children[2]
	delay = 0.2

	pointer.animate
		properties: scaleY: 0
		curve: "ease-in-out"
		time: 0.3
		delay: 0.1
	
	avatar.animate
		properties:
			scale: 0.5
			opacity: 0
		curve: "spring(200,20,10)"

# Pages
allPages = []
pages = new PageComponent width: screenW, height: screenH, parent: site.content
pages.scrollHorizontal = false
pages.animationOptions =
	curve: "spring(100,20,0)"

pages.mouseWheelEnabled = isFullscreen

pagesTotalWidth = screenW * (sections.length - 1)

for i,section of sections
	page = new Layer
		parent: pages.content
		name: section.name
		width: pages.width, height: pages.height
		y: i * pages.height
		backgroundColor: null
		opacity: 1
	
	usp = new Layer
		parent: page
		html: section.content
		backgroundColor: null
		width: 280 * x, y: 130 * x
	usp.centerX()
	usp.style =
		"font-family": "Roboto"
		"font-weight": "300"
		"font-size": 16 * x + "px"
		"line-height": "1.5"

	if i == "0"
		usp.y = (150 + 48) * x
	
	title = new Layer
		parent: usp
		html: section.title
		backgroundColor: null
		width: usp.width, height: 27 * x
		x: Align.left, y: Align.top(-(27 + 26) * x)
	title.style =
		"font-family": "Roboto Condensed"
		"text-transform": "uppercase"
		"font-size": "#{18*x}px"
		"line-height": "1.5"
		"letter-spacing": "1.33px"
		"font-weight": "400"
	
	allPages.push(page)

# Fixed elements
fixed = new Layer
	backgroundColor: null
	width: Screen.width, height: Screen.height
	parent: site.content

if isPhone || isTablet || isFullscreen and Utils.isPhone()
	
# 	if not Utils.isSafari() || not Utils.isChrome()
# 
# 		ios = new Layer
# 			width: screenW
# 			height: 40 * x
# 		
# 		ios.style = 
# 			"background": "url(images/ios.png) rgba(250,250,250,0.9)"
# 			"-webkit-backdrop-filter": "blur(10px)"
# 			"box-shadow": "0 1px 0 #B2B2B2"
# 		if isTablet
# 			ios.style = "background-image": "url(images/ios_tab.png)"
# 				
# 		
# 		ios.onClick ->
# 			pages.snapToPage(allPages[0])
	
	banner = new Layer
		width: screenW, height: 83 * x
		image: "images/smartappbanner.png"
		parent: fixed
		y: 0
	appstoreURL = "https://itunes.apple.com/nl/app/suitsupply/id1038908407?mt=8"
	link = new Layer
		parent: banner
		width: 83 * x
		height: 83 * x
		ignoreEvents: false
		backgroundColor: null
		html: "<a href='#{appstoreURL}' target='_blank' style='position:absolute; width: 100%; height: 100%;'></a>"
		x: Align.right
	
logo = new Layer
	parent: fixed
	image: "images/g_logo.png"
	width: 280 * x, height: 16 * x
	y: banner.maxY + 48 * x	
logo.centerX()

logo.states.add small: scale: 0.5, y: 20 * x

logo.states.animationOptions =
	curve: "spring(200,40,10)"

ss_logo = new Layer
	parent: allPages[0]
	image: "images/by_ss.png"
	width: 77 * x, height: 6 * x
	x: Align.center, y: logo.maxY + 12 * x
ss_logo.states.add
	hide: opacity: 0
	

cta = new Layer
	parent: fixed
	width: 252 * x, height: 48 * x
	image: "images/cta.png"
	y: Align.bottom(-48 * x)
cta.centerX()
link = new Layer
	parent: cta
	width: cta.width
	height: cta.width
	ignoreEvents: false
	backgroundColor: null
	html: "<a href='#{appstoreURL}' target='_blank' style='position:absolute; width: 100%; height: 100%;'></a>"


ctaHide = new Animation
	layer: cta
	properties: opacity: 0, y: Align.bottom
	curve: "ease-in-out"
	time: 0.2

ctaShow = ctaHide.reverse()

if isFullscreen || isTablet
	cta.width = 250 * x
	cta.height = 108 * x
	cta.image = "images/cta_tab.png"
	cta.y = Screen.height - 156 * x

readMore = new Layer
	width: 100 * x, height: 50 * x
	backgroundColor: null
	parent: fixed
	x: Align.center
	y: allPages[0].children[0].maxY + 24 * x

readMore.style = 
	"font-size": "#{16*x}px"
	"font-family": "Roboto Condensed"
	"text-transform": "uppercase"
	"text-align": "center"
	"line-height": "1.5"

readMoreTxt = new Layer
	parent: readMore
	width: readMore.width, height: readMore.height / 2
	html: "How it works"
	backgroundColor: null

readMore.states.add
	hide: 
		y: 220 * x

readMoreTxt.states.add
	hide: opacity: 0
	
arrDown = new Layer
	width: 19 * x, height: 10 * x
	parent: readMore
	x: Align.center, y: Align.bottom
	image: "images/arr_down.png"

arrDownAnimation = new Animation
	layer: arrDown
	properties:
		opacity: 0
		y: Align.bottom(arrDown.height)
	time: 0.5
	delay: 1
	curve: "eae-in-out"

arrDownAnimation.onAnimationEnd ->
	arrDown.y = Align.bottom
	arrDown.animate
		properties: opacity: 1
		time: 0.4
		curve: "eae-in-out"
		delay: 0.5
	Utils.delay 1, ->
		arrDownAnimation.start()

arrDownAnimation.start()

arrDown.onClick ->
	pages.snapToPage(allPages[1])

		

# Footer
footer = new Layer
	width: screenW, height: (280) * x + cta.height
	backgroundColor: "#f2f2f2"

footerBottom = new Layer
	parent: footer
	width: footer.width, height: 280 * x
	backgroundColor: "#e9e9e9"
	
footerImg = new Layer	
	parent: footerBottom
	width: 375 * x, height: 280 * x
	image: "images/footer.png"
# Add footer as page to site
site.addPage(footer,"bottom")

# Behavior
firstPage = 0
lastPage = allPages.length - 1

showGarmentor = Utils.throttle 0.5, (garmentor) ->
	garmentor.animate
		properties: opacity: 1

site.onScroll ->
	if site.direction == "up" && site.currentPage == city
		site.scrollVertical = false
		pages.scrollVertical = true

site.on "change:currentPage", ->
	if site.direction == "up"	
		site.scrollVertical = false
		pages.scrollVertical = true

# Click on down arrow go to next page
readMore.onClick ->
	current = pages.verticalPageIndex(pages.currentPage)
	next = current + 1
	if next < sections.length
		nextPage = allPages[current + 1]
		pages.snapToPage(nextPage)

# Page events
pages.on "change:currentPage", ->
	current = pages.verticalPageIndex(pages.currentPage)
	
	# If first page is left, shrink garmentor logo and hide ss logo
	if current == 1
# 		logo.states.switch("small")
		ss_logo.states.switch("hide")
		# and show garmentors and animate skyline
		skylineMoveRight.start()
		for i,gar of allGarmentors
			showGarmentors(gar,i)
		# move cta down
		if pages.direction == "down" then ctaHide.start()
		# Remove "read more" text
		readMore.states.next("hide")
		readMoreTxt.states.next("hide")
		
	# When you come back on first page make garmentor logo big and show ss logo again
	if current == 0
# 		logo.states.switch("default")
		ss_logo.states.switch("default")
		# and hide garmentors and stop skyline animation
		skylineMoveRight.stop()
		skylineMoveLeft.stop()
		for i,gar of allGarmentors
			hideGarmentors(gar,i)
		# and move cta back up
		ctaShow.start()
		# Place "read more" text back
		readMore.states.next("default")
		readMoreTxt.states.next("default")
	
	if current == lastPage
		# show cta
		ctaShow.start()
		# Hide readmore
		readMore.opacity = 0
	if current == lastPage - 1
		# hide cta
		ctaHide.start()
		# show readMore
		readMore.opacity = 1
	
pages.content.on "change:y", ->
	logo.scale = Utils.modulate pages.content.y, [0,-1334], [1,0.5], true
	logo.y = Utils.modulate pages.content.y, [0,-1334], [banner.maxY + 48 * x,20 * x], true
	banner.y = Utils.modulate pages.content.y, [0,-banner.height], [0,-banner.height], true

	currentPage = pages.verticalPageIndex(pages.currentPage)
	
	deltaY = Math.abs (-pages.content.y) - pages.currentPage.y
	pages.currentPage.opacity = Utils.modulate deltaY, [0,200], [1,0], false
	pages.currentPage.scale = Utils.modulate deltaY, [0,200], [1,0.9], false
	
	if currentPage != lastPage
		site.scrollVertical = false
		pages.scrollVertical = true
	else
		if pages.direction == "down"
			site.scrollVertical = true
			pages.scrollVertical = false
	
# Skyline pan
skylineA = -screenW / 2
skylineB = -skyline.width / 5

# Continuous motion
skylineMoveRight = new Animation
	layer: skyline
	properties:
		x: skylineB
	time: 10
	curve: "ease-out-out"
skylineMoveLeft = skylineMoveRight.reverse()

skylineMoveRight.onAnimationEnd ->
	skylineMoveLeft.start()

skylineMoveLeft.onAnimationEnd ->
	skylineMoveRight.start()

# Sky pan, dependant on x change of skyline
skyline.on "change:x", ->
	sky.x = Utils.modulate @x, [skylineA, skylineB], [-screenW / 2,-sky.width + screenW]
# 	print @x - skylineA
	for i,gar of allGarmentors
		garX = gar.x - @x

# Toggles
hash = ""
location = ""

if window.location.hash
	hash = window.location.hash.substring(1); #Puts hash in variable, and removes the # character
	location = hash
else
	location = "amsterdam"

if location == "amsterdam"
	buildings.image = "images/ams.png"
else if location == "newyork"
	buildings.image = "images/ny.png"
else if location == "dallas"
	buildings.image = "images/dal.png"


