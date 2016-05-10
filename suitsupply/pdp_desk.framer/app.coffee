# Import file "SS-Box-Office-My-Box_V2" (sizes and positions are scaled 1:2)
pdp = Framer.Importer.load("imported/SS-Box-Office-My-Box_V2@2x")

Framer.Defaults.Animation =
	curve: "spring(400,40,10)"

bg = new BackgroundLayer
bg.style = 
	"background": "url(images/looks-.png) center center"

if Framer.Device.deviceType == "fullscreen"
	Framer.Device.setContentScale(0.5)
else
	Framer.Device.setContentScale(1)

x = 2
pageCount = pdp.products.subLayers.length
pdp.looks_pdp.center()
pdp.looks_pdp.opacity = 0
pdp.looks_pdp.scale = 0.9

mask = new Layer
	width: Screen.width, height: Screen.height
	backgroundColor: "#000"
	opacity: 0
mask.sendToBack()
bg.sendToBack()

showMask = new Animation
	layer: mask
	properties:
		opacity: 0.75
hideMask = showMask.reverse()

showPDP = new Animation
	layer: pdp.looks_pdp
	properties: 
		opacity: 1
		scale: 1
hidePDP = showPDP.reverse()

# Array that will store our layers
allIndicators = []

views = new PageComponent
	width: 1008 * x, height: pdp.looks_pdp.height
	scrollVertical: false
	directionLock: true
	contentInset: left: 16, right: 16
	parent: pdp.looks_pdp
views.backgroundColor = "#fff"
views.centerX()

indicatorWrap = new Layer
	width: 1008 * x, height: 48 * x
	backgroundColor: "#fff"
	maxY: pdp.looks_pdp.height
	style: {"border-top": "2px solid #E9E9E9"}
	parent: pdp.looks_pdp
indicatorWrap.centerX()

pdp.prev.bringToFront()
pdp.next.bringToFront()
pdp.header.bringToFront()
pdp.header.backgroundColor = "#fff"

for i in [0...pageCount]
	scroll = new ScrollComponent
		width: views.width, height: 902 * x
		x: i * views.width
		scrollHorizontal: false
		directionLock: true
		contentInset: top: pdp.header.maxY + 48 * x, bottom: 48 * x
	pdp["product#{i}"].parent = scroll.content
	pdp["product#{i}"].centerX()
	
	views.addPage scroll
	
	indicator = new Layer 
		backgroundColor: "#f2f2f2"
		width: 20, height: 20
		x: 32 * i
		borderRadius: "50%", opacity: 1
		parent: indicatorWrap
	indicator.centerY()
		
	# Stay centered regardless of the amount of cards
	indicator.x += (pdp.looks_pdp.width / 2) - (20 * pageCount)
	
	# States
	indicator.states.add(active: {backgroundColor: "#3376C9"})
	indicator.states.animationOptions = time: 0.5
	
	# Store indicators in our array
	allIndicators.push(indicator)

# Set indicator for current page
views.snapToPage(views.content.subLayers[0])
current = views.horizontalPageIndex(views.currentPage)
allIndicators[current].states.switch("active")

if current == 0
	pdp.prev.opacity = 0

# Update indicators
views.on "change:currentPage", ->
	indicator.states.switch("default") for indicator in allIndicators
	
	current = views.horizontalPageIndex(views.currentPage)
	allIndicators[current].states.switch("active")
	if current == 0 then pdp.prev.opacity = 0 else pdp.prev.opacity = 1
	if current == pageCount - 1 then pdp.next.opacity = 0 else pdp.next.opacity = 1

pdp.prev.onClick ->
	views.snapToPreviousPage()

pdp.next.onClick ->
	views.snapToNextPage()

views.onClick ->
	showPDP.start()
	showMask.start()

pdp.header.onClick ->
	hidePDP.start()
	hideMask.start()

mask.onClick ->
	hidePDP.start()
	hideMask.start()