# Require jQuery
$ = require("npm").jquery

# Require TextLayer
TextLayer = require("TextLayer")

# Device
# deviceType can be either "phone" or "desktop"
x = 0.25
Framer.DeviceView.Devices["custom"] =
"deviceType": "tv"
"screenWidth": 1080 * x
"screenHeight": 3840 * x

# Set custom device
Framer.Device.deviceType = "custom"

# Variables
delay = 1
spring = "spring(200,50,0)"
cardW = 940 * x
cardH = 220 * x
cardP = 40 * x
darkblue = "#183051"

bg = new BackgroundLayer backgroundColor: darkblue

reviewsHolder = new Layer
	width: cardW, height: (cardH + cardP) * 4 + 80 * x, clip: true, backgroundColor: null
reviewsHolder.center()

reviews = new PageComponent
	parent: reviewsHolder
	width: reviewsHolder.width, height: cardH
	backgroundColor: null, clip: false
reviews.scrollHorizontal = false

reviews.centerX()

# Cards
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
			backgroundColor: "rgba(255,255,255,0.9)"
			scale: 0.5, opacity: 0.2
		name = new TextLayer
			scale: 0.5, opacity: 0.2
			parent: card
			text: e.name
			color: darkblue
		
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
