# >>> Framer Fold >>>
# Sharing Info
# This info is presented in a widget when you share

Framer.Info =
	title: "The Garmentor Landing page version 2"
	description: ""
	author: "Elliot Nolten"
	twitter: "@elliotnolten"

# <<< Framer Fold <<<

# Globals and settings
screenW = Screen.width
screenH = Screen.height

Utils.insertCSS("@import 'https://fonts.googleapis.com/css?family=Roboto:300';")
bg = new BackgroundLayer backgroundColor: "#183150"
Framer.Defaults.Animation =
	curve: "spring(200,20,10)"

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

# Skyline
city = new Layer width: screenW, height: screenH, backgroundColor: null

sky = new Layer
	parent: city
	width: 1846, height: screenH, x: -screenW / 2
	image: "images/sky.png"

pageOverlay = new Layer
	parent: city
	width: Screen.width, height: Screen.height, backgroundColor: null
pageOverlay.style = "background": "linear-gradient(to bottom, rgba(24,48,81,0.6), rgba(24,48,81,0))"

skyline = new Layer
	parent: city
	width: 2000, height: screenH
	x: -screenW / 2, backgroundColor: null
	
buildings = new Layer
	parent: skyline
	width: skyline.width, height: 366
	image: "images/skylineNY.png"
	maxY: screenH - 79

water = new Layer
	parent: city
	width: 2500, height: 79
	image: "images/water.png"
	x: -screenW / 2, maxY: screenH

# List of garmentors
garmentors = [
	{ name: "annabel", x: 400, y: 450, eta: 22, bottom: 260 }
	{ name: "ashley", x: 800, y: 450, eta: 24, bottom: 300 }
	{ name: "you", x: 800, y: 450, eta: "", bottom: 300 }
	{ name: "charity", x: 900, y: 750, eta: 30, bottom: 300 }
	{ name: "courtney", x: 1000, y: 350, eta: 39, bottom: 340 }
	{ name: "estefania", x: 1200, y: 730, eta: 45, bottom: 300 }
	{ name: "jordan", x: 1340, y: 400, eta: 50, bottom: 280 }
# 	{ name: "judy", x: 1500, y: 620, eta: 56, bottom: 340 }
# 	{ name: "laura", x: 1600, y: 420, eta: 56, bottom: 340 }
# 	{ name: "saar", x: 1740, y: 720, eta: 56, bottom: 340 }
# 	{ name: "sophie", x: 1890, y: 360, eta: 56, bottom: 340 }
# 	{ name: "travis", x: 2000, y: 420, eta: 56, bottom: 340 }
]
allGarmentors = []
allGarY = []
allGarHeight = []

for i,gar of garmentors
	
	deviation = Utils.randomNumber(-0.02,0.02)
	xPos = (skyline.width - 360) / garmentors.length * i + 360
	yPos = Utils.randomNumber(720,900)
	
	garmentor = new Layer
		parent: skyline
		size: 34 * 2
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
		width: garmentor.width + 24, height: garmentor.height + 24
		borderRadius: (garmentor.width + 24) / 2, backgroundColor: null
	ring.style =
		"border": "6px solid #183051"
	ring.center()
	
	eta = new Layer
		parent: avatar, html: "ETA #{gar.eta} min", backgroundColor: null, height: 40, y: -56
	eta.centerX()
	eta.style = 
		"text-align": "center"
		"font-size": "28px"
		"line-height": "42px"
		"font-family": "Roboto"
		"font-weight": "300"
	
	garmentor.scale = Utils.randomNumber(0.5,1.25)
	
	if gar.name == "you"
		eta.html = "you"
		ring.opacity = 0
	
	pointer = new Layer
		parent: garmentor
		width: 2, height: Screen.height - garmentor.height + 40, y: garmentor.height + 40
		backgroundColor: "rgba(255,255,255,0.5)"
	pointer.centerX()
	pointer.scaleY = 0
	
	allGarmentors.push(garmentor)
	allGarY.push(yPos)

buildings.bringToFront()

# Pages
allPages = []
pages = new PageComponent width: Screen.width, height: Screen.height
pages.scrollVertical = false

pagesTotalWidth = screenW * (sections.length - 1)

for i,section of sections
	page = new Layer
		parent: pages.content
		width: pages.width, height: pages.height
		x: i * pages.width
		backgroundColor: null
		
	icon = new Layer
		parent: page
		size: 72 * 2, y: 256
		backgroundColor: null
		image: "images/#{section.icon}"
	icon.centerX()
	
	usp = new Layer
		parent: page
		html: section.content
		backgroundColor: null
		width: page.width - 56 * 4, y: 215 * 2
	usp.centerX()
	usp.style =
		"font-family": "Roboto"
		"font-weight": "300"
		"font-size": "32px"
		"line-height": "1.5"
	
	allPages.push(page)

# Fixed elements
fixed = new Layer
	backgroundColor: null
	width: Screen.width, height: Screen.height
	
logo = new Layer
	parent: fixed
	image: "images/g_logo.svg"
	width: 248 * 2, height: 19 * 2
	y: 300
logo.centerX()

logo.states.add small: scale: 0.5, y: 120

logo.states.animationOptions =
	curve: "spring(200,40,10)"
	
ios = new Layer
	parent: fixed
	width: 750
	height: 80
	image: "images/ios.png"
ios.onClick ->
	pages.snapToPage(allPages[0])

cta = new Layer
	width: 252 * 2, height: 108 * 2
	image: "images/cta.png"
	maxY: Screen.height - 48
cta.centerX()

ss_logo = new Layer
	image: "images/sslogo.svg"
	width: 120 * 2, height: 14 * 2
	x: 24 * 2, y: 64 * 2

ss_logo.states.add hide: opacity: 0

# Behavior
for i,garmentor of allGarmentors
	# If garmentor is in viewport
	if screenW + screenW * 0.2 > garmentor.x
		# Animate pointer
		garmentor.children[1].animate
			properties: scaleY: 1
			time: 0.3
			curve: "ease-in-out"
			delay: i * 0.3 + 0.5
		# Then pop images
		garmentor.children[0].animate
			properties: scale: 1, opacity: 1
			delay: i * 0.3 + 0.8

firstPage = 0
lastPage = allPages.length - 1

showGarmentor = Utils.throttle 0.5, (garmentor) ->
	garmentor.animate
		properties: opacity: 1
		
pages.onMove ->
	sky.x = Utils.modulate pages.scrollX, [0,pagesTotalWidth], [-screenW / 2,-sky.width + screenW * 1.25]
	skyline.x = Utils.modulate pages.scrollX, [0,pagesTotalWidth], [-screenW / 2,-skyline.width + screenW * 1.25]
	water.x = Utils.modulate pages.scrollX, [0,pagesTotalWidth], [-screenW / 2,-water.width + screenW * 1.5]


# Page events
pages.on "change:currentPage", ->
	current = pages.verticalPageIndex(pages.currentPage)
	
	# If first page is left, shrink garmentor logo and hide ss logo
	if current == 1
		logo.states.switch("small")
		ss_logo.states.switch("hide")
	# When you come back on first page make garmentor logo big and show ss logo again
	if current == 0
		logo.states.switch("default")
		ss_logo.states.switch("default")
	
	for i,garmentor of allGarmentors
		# If garmentor is in viewport
		if pages.scrollX > garmentor.x
			# Animate pointer
			garmentor.children[1].animate
				properties: scaleY: 1
				time: 0.3
				curve: "ease-in-out"
				delay: 0.2
			# Then pop images
			garmentor.children[0].animate
				properties: scale: 1, opacity: 1
				delay: 0.6 + 0.2