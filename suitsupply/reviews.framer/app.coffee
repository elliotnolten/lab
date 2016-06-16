# Require jQuery
$ = require("npm").jquery

# Require TextLayer
TextLayer = require("TextLayer")

# Device
# deviceType can be either "phone" or "desktop"
x = Screen.height / 3840
Framer.DeviceView.Devices["custom"] =
"deviceType": "tv"
"screenWidth": 1080 * x
"screenHeight": 3840 * x

# Set custom device
Framer.Device.deviceType = "custom"
darkblue = "#183051"
bg = new BackgroundLayer backgroundColor: darkblue

# Top Screen
top = new Layer
	width: Screen.width, height: 2272 * x
	image: "images/top_screen.png"

# Employees
# Variables
delay = 4
spring = "spring(200,50,0)"
cardW = 940 * x
cardH = 220 * x
cardP = 40 * x

employeeTitle = new TextLayer
	text: "All employees"
	color: "#fff"
	fontFamily: "Roboto Condensed"
	fontWeight: 300
	x: 70 * x, y: 2016 * x
	fontSize: 56 * x
	

reviewsHolder = new Layer
	width: cardW, height: (cardH + cardP) * 4 + 80 * x, clip: true, backgroundColor: null, y: 2140 * x
reviewsHolder.centerX()

reviews = new PageComponent
	parent: reviewsHolder
	width: reviewsHolder.width, height: cardH
	backgroundColor: null, clip: false
reviews.scrollHorizontal = false
reviews.content.backgroundColor = null

reviews.centerX()

# Cards
# https://sheetsu.com/apis/v1.0/8fea45d7
feed = $.ajax
	url: "employees.json"
	contentType: "application/json;"
	dataType: "json"
	jsonpCallback: "callback"

feed.error ->
	print "feed.statusText"
	
feed.done (data) ->
	# Variables
	cards = []
	cardSet = 4
	
	# Create cards
	$.each data,(i,e) ->
		card = new Layer
			parent: reviews.content
			width: cardW, height: cardH, y: (i - 1) * (cardH + cardP)
			backgroundColor: null
		cardShadow = new Layer
			parent: card
			width: card.width * 0.9, height: card.height * 0.9
			y: 10
			backgroundColor: "rgba(0,0,0,0.5)"
			blur: 10
			scale: 0.5, opacity: 0.2
		cardContainer = new Layer
			parent: card
			width: card.width, height: card.height
			backgroundColor: "rgba(255,255,255,1)"
			scale: 0.5, opacity: 0.2
		content = new Layer
			parent: card
			backgroundColor: null
			width: card.with, height: card.height
			scale: 0.5, opacity: 0.2
		pic = new Layer
			parent: content
			backgroundColor: null
			size: 140 * x, x: 40 * x
			image: e.picture
		pic.centerY()
		name = new TextLayer
			parent: content
			x: 240 * x, y: 54 * x
			text: e.name
			color: darkblue
			fontFamily: "Roboto Condensed"
			fontWeight: 300
			fontSize: 36 * x
			lineHeight: 1.5
		icClock = new Layer
			parent: content
			size: 36 * x
			image: "images/ic_clock_dark.svg"
			x: 240 * x, y: 120 * x
		time = new TextLayer
			parent: content
			text: "Available until " + e.time
			color: darkblue
			fontFamily: "Roboto Condensed"
			fontWeight: 300
			fontSize: 36 * x
			lineHeight: 1.5
			x: 296 * x, y: 110 * x
		rox = new TextLayer
			parent: content
			text: e.rox + "%"
			fontSize: 90 * x
			fontFamily: "Roboto Condensed"
			fontWeight: 300
			lineHeight: 1.5
			color: darkblue
			x: 720 * x, y: 42 * x
		
		cardShadow.centerX()
		cards.push(card)
	
	cardCount = cards.length
	index = 1
	maxIndex = cardCount - cardSet
	
# 	Transform children
	transformChild = (layer,curve,time) ->
		for i,child of layer.children
			child.animate
				properties:
					opacity: 1
					scale: 1
				curve: curve
				time: time

# 	Scale last cards
	for i,card of cards
		if cardCount - 1 - cardSet - 1 < i
			transformChild(card,"linear",0)
# 	
	# # Snap to last 4 pages
	reviews.snapToPage(cards[cardCount - 1 - cardSet],false)
	# 
	# # Animation
	moveCards = () ->
		if  index < cardCount - 1 - cardSet
			nextPage = cards[cardCount - 1 - cardSet - index]
			lastPage = cards[cardCount - 1 - cardSet - index + 4]
			reviews.snapToPage(nextPage,true,animationOptions = curve: spring)
			transformChild(nextPage,spring)
			lastPage.sendToBack()
			lastPage.animate
				properties:
					y: lastPage.y - (cardH + cardP)
					opacity: 0
					scale: 0.9
				curve: spring
			
			index++
		else 
			return

	Utils.interval delay, ->
		moveCards()

yelp = new Layer
	width: 1080 * x, height: 518 * x, y: 3236 * x
	image: "images/yelp.png"