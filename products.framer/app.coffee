# Import modules
$ = require("npm").jquery
TextLayer = require("TextLayer")

# set some variables
cardW = Screen.width - 48
cardH = 200

# create a page component
pages = new PageComponent
	width: Screen.width, height: Screen.height
	# No scrolling
	scrollVertical: false, scrollHorizontal: false
	# The direction lock is enabled to only allow either horizontal or vertical scrolling
	directionLock: true

# create a scrollcomponent
list = new ScrollComponent
	width: Screen.width, height: Screen.height - 100, backgroundColor: "#f0ede7"
	y: 100
list.scrollHorizontal = false
list.contentInset =
	top: 48
	bottom: 48

# add scrollable list to page component
pages.addPage list

# create fixed header
header = new Layer
	width: Screen.width, height: 100, backgroundColor: "#36c"

class product extends Layer
	constructor: (color) ->
		super()
		

feed = $.ajax
	url: "http://nolten.co/bolcomapi.php/lists/retailid=12554&limit=5"
	contentType: "application/jsonp;"
	dataType: "jsonp"
	jsonpCallback: "callback"

feed.error ->
	print "no products"
	
feed.done (data) ->
# 	print data.products
	$.each data.products,(i,e) ->
		card = new Layer
			superLayer: list.content
			name: e.id
			width: cardW, height: cardH
			x: -cardW, y: (cardH + 48) * i
			backgroundColor: "#fff"
			borderRadius: 14
			clip: true
		card.product = e
		
		image = new Layer
			superLayer: card
			width: cardH, height: cardH
			image: e.images[4].url
		image.style =
			"border-top-left-radius": "14px"
			"border-bottom-left-radius": "14px"
			
		
		title = new TextLayer
			superLayer: card
			x: 28 + cardH, y: 28
			text: e.title
			color: "#000"
			fontSize: 35
			autoSize: true
			fontFamily: "Open Sans"
			fontWeight: 300
		
		card.on Events.Click, ->
			image.width = Screen.width	
# 			createPDP(@product)
		
		card.animate
			properties:
				x: 24
			time: 0.5
			delay: 0.1 * i
		
		list.on Events.ScrollMove, ->
			card.ignoreEvents = true
		list.on Events.ScrollAnimationDidEnd, ->
			card.ignoreEvents = false
		
# 	Function for creating a product detail page
createPDP = (product) ->
	pdpContainer = new Layer
		width: Screen.width, height: Screen.height - header.height
		y: header.height
		backgroundColor: "#f0ede7"
	pdp = new ScrollComponent
		superLayer: pdpContainer
		width: Screen.width, height: Screen.height
		backgroundColor: "#f0ede7"
	pdp.scrollHorizontal = false
	
	mainImg = new Layer
		superLayer: pdp.content
		width: Screen.width, height: Screen.width
		backgroundColor: "#fff"
		image: product.images[4].url
	
		
			