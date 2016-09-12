# >>> Framer Fold >>>
# Sharing Info
# This info is presented in a widget when you share

Framer.Info =
	title: "The Garmentor Landing page version 2"
	description: ""
	author: "Elliot Nolten"
	twitter: "@elliotnolten"

# <<< Framer Fold <<<

# Globals, settings and wrappers
# Orientation module from https://github.com/joshmtucker/OrientationEvents
orient = require "OrientationEvents"

screenW = Screen.width
screenH = Screen.height

Utils.insertCSS("@import 'https://fonts.googleapis.com/css?family=Roboto:300';")

bg = new BackgroundLayer backgroundColor: "#f2f2f2"
Framer.Defaults.Animation =
	curve: "spring(200,20,10)"

site = new PageComponent
	width: screenW, height: screenH
site.scrollHorizontal = false
site.scrollVertical = false
site.directionLock = true

x = Utils.devicePixelRatio()

isFullscreen = Framer.Device.deviceType.indexOf("fullscreen") != -1
isPhone = Framer.Device.deviceType.indexOf("iphone") != -1
isTablet = Framer.Device.deviceType.indexOf("ipad") != -1
isRetina = true

if Framer.Device.deviceType.indexOf("htc") != -1 || Framer.Device.deviceType.indexOf("google") || Framer.Device.deviceType.indexOf("microsoft") || Framer.Device.deviceType.indexOf("samsung") then isPhone = true

if isPhone || isTablet != -1 then isRetina = true else isRetina = false

# if Utils.isPhone() && isPhone then isRetina = true else isRetina = false

if isRetina then x = 2 else x = 1

# Sections
sections = [
	{
		content: "Use the suitsupply app to get your perfect fit. Garmentors available between 10am and 6pm."
		image: "section1.png"
		name: "intro"
		icon: ""
	}
	{
		content: "On demand fitting session at home or office with one of our Garmentors"
		image: "section2.png"
		name: "usp1"
		icon: "pin.svg"
	}
	{
		content: "Your garmentor will assist you finding the perfect fit"
		image: "section3.png"
		name: "usp2"
		icon: "ruler.svg"
	}
	{
		content: "Pay for your alterations on-site and have your altered items delivered at your doorstep."
		image: "section4.png"
		name: "usp3"
		icon: "styled.svg"
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

if isFullscreen then buildings.y = Align.bottom(200 * x)

# List of garmentors
garmentors = [
	{ name: "annabel", x: 400, y: 450, eta: 22, bottom: 260 }
	{ name: "ashley", x: 800, y: 450, eta: 24, bottom: 300 }
	{ name: "you", x: 800, y: 450, eta: "", bottom: 300 }
	{ name: "charity", x: 900, y: 750, eta: 30, bottom: 300 }
	{ name: "courtney", x: 1000, y: 350, eta: 39, bottom: 340 }
	{ name: "estefania", x: 1200, y: 730, eta: 45, bottom: 300 }
	{ name: "jordan", x: 1340, y: 400, eta: 50, bottom: 280 }
# 	{ name: "sophie", x: 1890, y: 360, eta: 56, bottom: 340 }
# 	{ name: "travis", x: 2000, y: 420, eta: 56, bottom: 340 }
]
allGarmentors = []
allGarY = []
allGarHeight = []
garTop = verticalSections.middle.top
garBottom = buildings.minY + 100 * x

for i,gar of garmentors
	
	deviation = Utils.randomNumber(-0.05,0.05)
	xPos = (skyline.width - 360) / garmentors.length * i + 360
	yPos = Utils.randomNumber(garTop,garBottom)
	
	garmentor = new Layer
		parent: skyline
		size: 34 * x
		x: xPos + xPos * deviation, y: yPos
		backgroundColor: null
	
	avatar = new Layer
		parent: garmentor
		image: "images/garmentors/#{gar.name}.png"
		width: garmentor.width, height: garmentor.height
		opacity: 0
		scale: 0.8
		
	ring = new Layer
		parent: avatar
		width: garmentor.width + 12 * x, height: garmentor.height + 12 * x
		borderRadius: (garmentor.width + 12 * x) / 2, backgroundColor: null
	ring.style =
		"border": 3 * x + "px solid #183051"
	ring.center()
	
	eta = new Layer
		parent: garmentor, html: "ETA #{gar.eta} min", backgroundColor: null, height: 20 * x, y: -28 * x
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
		name: "pointer"
		parent: garmentor
		width: x, height: Screen.height - garmentor.height + 20 * x, y: garmentor.height + 20 * x
		backgroundColor: "rgba(255,255,255,0.5)"
	pointer.centerX()
	pointer.scaleY = 0
	
	allGarmentors.push(garmentor)
	allGarY.push(yPos)

buildings.bringToFront()

# Pages
allPages = []
pages = new PageComponent width: screenW, height: screenH, parent: site.content
pages.scrollHorizontal = false
pages.directionLock = true
pages.animationOptions =
	curve: "spring(100,20,0)"

pagesTotalWidth = screenW * (sections.length - 1)

for i,section of sections
	page = new Layer
		parent: pages.content
		name: section.name
		width: pages.width, height: pages.height
		y: i * pages.height
		backgroundColor: null
		opacity: 0
		
	icon = new Layer
		parent: page
		size: 72 * x, y: 128 * x
		backgroundColor: null
		image: "images/#{section.icon}"
	icon.centerX()
	
	usp = new Layer
		parent: page
		html: section.content
		backgroundColor: null
		width: 280 * x, y: 200 * x
	usp.centerX()
	usp.style =
		"font-family": "Roboto"
		"font-weight": "300"
		"font-size": 16 * x + "px"
		"line-height": "1.5"
	
	allPages.push(page)

allPages[0].opacity = 1

arrDown = new Layer
	width: 19 * x, height: 10 * x
	image: "images/arr_down.png"
	parent: allPages[0]
	x: Align.center, y: usp.maxY

arrDownAnimation = new Animation
	layer: arrDown
	properties:
		opacity: 0
		y: usp.maxY + arrDown.height
	time: 0.5
	delay: 1
	curve: "eae-in-out"

arrDownAnimation.onAnimationEnd ->
	arrDown.y = usp.maxY
	arrDown.animate
		properties: opacity: 1
		time: 0.4
		curve: "eae-in-out"
		delay: 0.5
	Utils.delay 1, ->
		arrDownAnimation.start()

arrDownAnimation.start()

# Fixed elements
fixed = new Layer
	backgroundColor: null
	width: Screen.width, height: Screen.height
	parent: site.content
	
logo = new Layer
	parent: fixed
	image: "images/g_logo.svg"
	width: 254 * x, height: 19 * x
	y: 150 * x
	
logo.centerX()

logo.states.add small: scale: 0.5, y: 60 * x

logo.states.animationOptions =
	curve: "spring(200,40,10)"

cta = new Layer
	parent: fixed
	width: 252 * x, height: 48 * x
	image: "images/cta.png"
	y: Screen.height - 96 * x
cta.centerX()

if isFullscreen || isTablet
	cta.width = 250 * x
	cta.height = 108 * x
	cta.image = "images/cta_tab.png"
	cta.y = Screen.height - 156 * x

ss_logo = new Layer
	parent: fixed
	image: "images/sslogo.svg"
	width: 120 * x, height: 14 * x
	x: 24 * x, y: 64 * x

ss_logo.states.add hide: opacity: 0

if isPhone || isTablet

	ios = new Layer
		width: screenW
		height: 40 * x
	
	ios.style = 
		"background": "url(images/ios.png) rgba(250,250,250,0.9)"
		"-webkit-backdrop-filter": "blur(10px)"
		"box-shadow": "0 1px 0 #B2B2B2"
	if isTablet
		ios.style = "background-image": "url(images/ios_tab.png)"
			
	
	ios.onClick ->
		pages.snapToPage(allPages[0])

# Footer
footer = new Layer
	width: screenW, height: 280 * x
	backgroundColor: "#f2f2f2"
	
footerImg = new Layer
	parent: footer
	width: 375 * x, height: 280 * x
	image: "images/footer.png"
# Add footer as page to site
site.addPage(footer,"bottom")

# Behavior
for i,garmentor of allGarmentors
	# Animate pointer
	garmentor.children[2].animate
		properties: scaleY: 1
		time: 0.3
		curve: "ease-in-out"
		delay: i * 0.3
	# Then pop images
	garmentor.children[0].animate
		properties: scale: 1, opacity: 1
		delay: i * 0.3 + 1

firstPage = 0
lastPage = allPages.length - 1

showGarmentor = Utils.throttle 0.5, (garmentor) ->
	garmentor.animate
		properties: opacity: 1
		
pages.onScroll ->
	currentPage = pages.verticalPageIndex(pages.currentPage)
	deltaY = Math.abs(pages.scrollY - pages.currentPage.y)
	# Fade out currentPage
	pages.currentPage.opacity = Utils.modulate deltaY, [0,200], [1,0], true
	pages.currentPage.scale = Utils.modulate deltaY, [0,200], [1,0.9], true
	
	if currentPage != lastPage
		site.scrollVertical = false
		pages.scrollVertical = true
	else
		if pages.direction == "down"
			site.scrollVertical = true
			pages.scrollVertical = false
# 	print pages.direction, "site = #{site.scrollVertical}, pages = #{pages.scrollVertical}"

site.onMove ->
	if site.direction == "up" && site.currentPage == city
		site.scrollVertical = false
		pages.scrollVertical = true

site.on "change:currentPage", ->
	if site.direction == "up"	
		site.scrollVertical = false
		pages.scrollVertical = true


# Page events
pages.on "change:currentPage", ->
	current = pages.verticalPageIndex(pages.currentPage)
	
	pages.previousPage.animate
		properties: opacity: 0
		curve: "spring(100,20,0)"
	
	# If first page is left, shrink garmentor logo and hide ss logo
	if current == 1
		logo.states.switch("small")
		ss_logo.states.switch("hide")
	# When you come back on first page make garmentor logo big and show ss logo again
	if current == 0
		logo.states.switch("default")
		ss_logo.states.switch("default")
	
# Skyline pan
# Accelerometer
# orient.OrientationEvents()
# orient.smoothMotion = 0.5
# Utils.interval .1, ->
# 
# 	if orient.orientation? # To make sure we're actually receiving orientation-values
# 
# 		gamma = orient.orientation.gamma
# 		
# 		skyline.animate
# 			properties:
# 				x: Utils.modulate(gamma, [-10, 10], [-screenW / 2, -skyline.width + screenW * 1.25], true)
# 			curve: "spring(450, 110, 0)"

# Continuous motion
skylineMoveRight = new Animation
	layer: skyline
	properties:
		x: -skyline.width + screenW * 1.25
	time: 60
	curve: "ease-out-out"
skylineMoveLeft = skylineMoveRight.reverse()

skylineMoveRight.onAnimationEnd ->
	skylineMoveLeft.start()

skylineMoveRight.start()

# Sky pan, dependant on x change of skyline
skyline.on "change:x", ->
	sky.x = Utils.modulate @x, [-screenW / 2, -skyline.width + screenW * 1.25], [-screenW / 2,-sky.width + screenW * 1.25]

# Toggles
hash = ""
location = ""

if window.location.hash
	hash = window.location.hash.substring(1); #Puts hash in variable, and removes the # character
	location = hash
else
	location = Utils.randomChoice(["amsterdam","newyork","dallas"])

if location == "amsterdam"
	buildings.image = "images/ams.png"
else if location == "newyork"
	buildings.image = "images/ny.png"
else if location == "dallas"
	buildings.image = "images/dal.png"
