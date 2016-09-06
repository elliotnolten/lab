# >>> Framer Fold >>>
# Sharing Info
# This info is presented in a widget when you share

Framer.Info =
	title: "The Garmentor Landing Page"
	description: ""
	author: "Elliot Nolten"
	twitter: "@suitsupply"

# <<< Framer Fold <<<

Utils.insertCSS("@import 'https://fonts.googleapis.com/css?family=Roboto:300';")
bg = new BackgroundLayer backgroundColor: "#183150"
Framer.Defaults.Animation =
	curve: "spring(200,15,10)"

# Variables
sections = [
	{
		content: "Use the suitsupply app to get your perfect fit. Garmentors available between 10am and 6pm."
		image: "section1.png"
		name: "intro"
	}
	{
		content: "On demand fitting session at home or office with one of our Garmentors"
		image: "section2.png"
		name: "usp1"
	}
	{
		content: "Your garmentor will assist you finding the perfect fit"
		image: "section3.png"
		name: "usp2"
	}
	{
		content: "Pay for your alterations on-site and have your altered items delivered at your doorstep."
		image: "section4.png"
		name: "usp3"
	}
	{
		content: ""
		image: ""
		name: "cta"
	}
	{
		content: ""
		image: "footer.png"
		name: "footer"
	}
]

Framer.Defaults.Animation = 
	curve: "spring(200,30,0)"

indicators = [
	{image: ""}
	{image: "pin.svg"}
	{image: "ruler.svg"}
	{image: "styled.svg"}
	{image: ""}
	{image: ""}
]
allPages = []
allIndicators = []
indicatorYs = []
indicatorSize = 56

# Create pages and indicators
pages = new PageComponent
	width: Screen.width, height: Screen.height
pages.scrollHorizontal = false
pages.contentInset = bottom: -800

pageOverlay = new Layer
	width: Screen.width, height: Screen.height, backgroundColor: null
pageOverlay.style = "background": "linear-gradient(to top, rgba(24,48,81,0.8), rgba(24,48,81,0))"

# Create page sections and indicators
for i,section of sections
	page = new Layer
		parent: pages.content
		width: pages.width, height: pages.height
		y: i * pages.height
		image: "images/#{section.image}"
		
	allPages.push(page)
	
	indicator = new Layer 
		size: indicatorSize * 2
		midX: -indicatorSize * 2, y: indicatorSize * 2 * i
		opacity: 0, scale: 0.5
		originX: 0.5, originY: 0.5
	
	allIndicators.push(indicator)
	indicator.image = "images/#{indicators[i].image}"
		
	# Stay centered regardless of the amount of cards
	indicator.y += (Screen.height / 2) - (indicatorSize * sections.length)
	
	indicatorYs.push(indicator.y)
	
	indicator.states.add
		active: scale: 1, opacity: 1
		inactive: scale: 0.5, opacity: 0.5
	indicator.states.animationOptions =
		curve: "spring(200,20,0)"
	
current = pages.horizontalPageIndex(pages.currentPage)
allIndicators[current].states.switch("active")

# Loop through all indicators
for i,indicator of allIndicators
	index = parseInt(i)
	if index > 0 && index < allIndicators.length - 1
		indicator.opacity = 1

# The last page is smaller
allPages[allPages.length - 1].height = 432

# All other layers
# Fixed layers
fixed = new Layer
	backgroundColor: null
	width: Screen.width, height: Screen.height
logo = new Layer
	parent: fixed
	image: "images/g_logo.svg"
	width: 248 * 2, height: 19 * 2
	y: 200
	x: 127
logo.centerX()

logo.states.add
	small:
		scale: 0.5
		y: 120
		
# USP text
usp = new Layer
	parent: fixed
	html: sections[0].content
	width: page.width - 96 * 2 - 24 * 2, height: page.height / 2
	y: 300
	backgroundColor: null
	y: 402
usp.style =
	"font-family": "Roboto"
	"font-size": "36px"
	"line-height": "1.5"
	"text-align": "center"
	"font-weight": "300"
usp.centerX()

ios = new Layer
	parent: fixed
	width: 750
	height: 80
	image: "images/ios.png"
ios.onClick ->
	pages.snapToPage(allPages[0])

# Interactive Garmentor finder
ctaPage = allPages[allPages.length - 2]

sky = new Layer
	parent: ctaPage
	width: 1846, height: 1334
	image: "images/sky.png"
sky.centerX()
cityScroll = new ScrollComponent
	parent: ctaPage
	width: ctaPage.width, height: ctaPage.height
cityScroll.scrollVertical = false

cityScroll.contentInset = 
	left: -360
	right: -360

skyline = new Layer
	parent: cityScroll.content, backgroundColor: null
	width: 3000, height: Screen.height

city = new Layer
	parent: skyline
	width: skyline.width, height: 642
	image: "images/skylineNY.png"
	maxY: Screen.height - 141

water = new Layer
	parent: skyline
	width: 6750, height: 141
	image: "images/water.png"
	maxY: Screen.height
	
skylineOverlay = new Layer
	parent: sky, width: skyline.width, height: skyline.width
skylineOverlay.style = "background": "linear-gradient(to bottom, rgba(24,48,81,0.5), rgba(24,48,81,0))"

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

for i,gar of garmentors
	deviation = Utils.randomNumber(-0.02,0.02)
	xPos = (skyline.width - 720) / garmentors.length * i + 360
	yPos = Utils.randomNumber(320,780)
	garmentor = new Layer
		parent: skyline
		image: "images/garmentors/#{gar.name}.png"
		size: 34 * 2
		x: xPos + xPos * deviation, y: yPos
		opacity: 0
	ring = new Layer
		parent: garmentor
		width: garmentor.width + 24, height: garmentor.height + 24
		borderRadius: (garmentor.width + 24) / 2, backgroundColor: null
	ring.style =
		"border": "6px solid #183051"
	ring.center()
	eta = new Layer
		parent: garmentor, html: "ETA #{gar.eta} min", backgroundColor: null, height: 40, y: -56
	eta.centerX()
	eta.style = 
		"text-align": "center"
		"font-size": "28px"
		"line-height": "42px"
		"font-family": "Roboto"
		"font-weight": "300"
	
	if gar.name == "you"
		eta.html = "you"
		ring.opacity = 0
	
	pointer = new Layer
		parent: garmentor
		width: 2, height: 200, y: garmentor.height + 40
		backgroundColor: "rgba(255,255,255,0.5)"
	pointer.centerX()
	pointerTopY = pointer.screenFrame.y - allPages[allPages.length - 1].screenFrame.y
	pointerBottomY = Screen.height
	pointer.height = pointerBottomY - pointerTopY
	
	allGarmentors.push(garmentor)
	allGarY.push(yPos)

city.bringToFront()
water.bringToFront()
	


# Buttons
btn_second = new Layer
	width: 504
	height: 96
	image: "images/btn_second.png"
	y: 1069
btn_second.centerX()

btn_request = new Layer
	width: 508
	height: 100
	image: "images/btn_find.png"
	y: 919
btn_request.centerX()

btn_request.states.add
	stateA:
		y: 1069
	stateB:
		y: 919

appStores = btn_second.copySingle()
appStores.image = "images/app_stores.png"
appStores.opacity = 0


btn_second.states.add
	hide:
		opacity: 0

btn_request.onClick ->
	pages.snapToPage(allPages[allPages.length - 2])

btn_second.onClick ->
	pages.snapToNextPage("down")

# Events
last = allIndicators.length - 1
cta = allIndicators.length - 2

hideIndicators = () ->
	# Show indicators
	print "show indicators"
	for i, indicator of allIndicators
		indicator.animate
			properties: midX: indicatorSize
			delay: i * 0.1

pages.on "change:currentPage", ->
	current = pages.verticalPageIndex(pages.currentPage)
	usp.html = sections[current].content

	# Indicate the active page
	for i,indicator of allIndicators
		indicator.states.switch("inactive")
		indicator.animate
			properties: y: indicatorYs[i] - indicatorSize * 2 * (current - 0.5)
			time: 0.2
			curve: "ease-in-out"
	allIndicators[current].states.switch("active")
		
	if current != 0 or current != cta or current != last
		btn_second.ignoreEvents = true
		usp.animate properties: x: (pages.width - usp.width) / 2 + indicatorSize
		usp.style = "text-align": "left"
		logo.states.switch("small")
		btn_request.states.switch("stateA")
		btn_second.states.switch("hide")
		hideIndicators()
	
	if current == 0 || current == cta || current == last
		usp.style = "text-align": "center"
		usp.animate properties: x: (pages.width - usp.width) / 2
		
		# Hide indicators
		print "hide indicators"
		for indicator in allIndicators
			indicator.animate
				properties: x: -indicator.width
		btn_request.states.switch("stateB")
	
	if current == 0
		btn_second.states.switch("default")
		btn_second.ignoreEvents = false
		logo.states.switch("default")
	
	if current >= cta
		pageOverlay.animate properties: opacity: 0
		appStores.animate
			properties: opacity: 1
	else
		pageOverlay.animate properties: opacity: 1
		appStores.animate properties: opacity: 0
	
	# Animate Garmentors
	if current == cta
		for i,garmentor of allGarmentors
			garmentor.animate
				properties: y: allGarY[i] - 50, opacity: 1
				delay: i * 0.2
	else
		for i,garmentor of allGarmentors
			garmentor.y = allGarY[i] + 50
			garmentor.opacity = 0
	
	# If current page is cta and beyond, show 'download' button
	if current >= cta then btn_request.image = "images/btn_download.png" else btn_request.image = "images/btn_find.png"
	
	# if current page is last, move buttons up with cta page
	if current == last
		btn_request.parent = allPages[cta]
		appStores.parent = allPages[cta]
		logo.parent = allPages[cta]
	else
		Utils.delay 0.5, ->
			btn_request.parent = fixed
			appStores.parent = fixed
			logo.parent = fixed

# if you are skimming through skyline, prevent page scroll
cityScroll.onScroll ->
	pages.scrollVertical = false
cityScroll.onScrollEnd ->
	pages.scrollVertical = true

# Sky parallax
cityScroll.onMove ->
	sky.midX = Utils.modulate(cityScroll.scrollX, [0,1950],[sky.width / 3,375])
	water.midX = Utils.modulate(cityScroll.scrollX, [0,1950],[800,0],true)

logo.onClick ->
	pages.snapToPage(allPages[0])

