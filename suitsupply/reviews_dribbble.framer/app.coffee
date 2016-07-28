# Setup scene
# Require jQuery
$ = require("npm").jquery

# Require TextLayer
TextLayer = require("TextLayer")

# Device
# deviceType can be either "phone" or "desktop"
x = Screen.height / 3840
Framer.DeviceView.Devices["tv"] =
	"deviceType": "desktop"
	"screenWidth": 800 * 3 * x
	"screenHeight": 600 * 3 * x
	"deviceImageWidth": 800 * 3 * x
	"deviceImageHeight": 600 * 3 * x

# Set custom device
Framer.Device.deviceType = "tv"



screenMidX = Screen.width / 2
screenMidY = Screen.height / 2

darkblue = "#183051"

document.body.style.cursor = "none"

# Dark blue background
bg = new BackgroundLayer backgroundColor: "#183051", image: "images/nysoho.jpg", width: Screen.width, height: Screen.height
gradient = new Layer width: Screen.width, height: Screen.height, backgroundColor: darkblue, maxY: Screen.height, opacity: 0.5
# gradient.style.background = "-webkit-linear-gradient(top, transparent 30%, #183051 100%)"

# Activity timeline

# Variables
delay = 4
spring = "cubic-bezier(.75,.01,.25,1)"
cardW = 940 * x
cardH = 354 * x
cardP = 80 * x
cards = []
cardSet = 3

reviewsHolder = new Layer
	width: cardW, height: (cardH + cardP) * cardSet + 80 * x, clip: true, backgroundColor: null
reviewsHolder.center()
reviews = new PageComponent
	parent: reviewsHolder
	width: reviewsHolder.width, height: cardH
	backgroundColor: null, clip: false
reviews.scrollHorizontal = false
reviews.content.backgroundColor = null

reviews.centerX()

feed = $.ajax
	url: "employees.json"
	contentType: "application/json;"
	dataType: "json"
	jsonpCallback: "callback"

feed.error ->
	print "feed.statusText"
	
feed.done (data) ->
	# Variables
	
	
	# Create cards
	$.each data,(i,e) ->
		card = new Layer
			parent: reviews.content
			width: cardW, height: cardH, y: (i - 1) * (cardH + cardP)
			backgroundColor: null
		timeStamp = new Layer
			parent: card
			width: card.width, height: 54 * x, backgroundColor: null
		icClock = new Layer
			parent: timeStamp
			image: "images/ic_clock_white.svg", size: 36 * x
			maxX: timeStamp.maxX
		time = new TextLayer
			parent: timeStamp
			text: Math.round(i/4) + " hours ago"
			color: "#fff", fontFamily: "Roboto Condensed", fontWeight: 100, fontSize: 36 * x, lineHeight: 1, textAlign: "right"
			maxX: icClock.x - icClock.width
		cardContainer = new Layer
			parent: card
			width: card.width, height: 304 * x
			backgroundColor: "rgba(255,255,255,1)"
			scale: 0.5, opacity: 0.2
			borderRadius: 8 * x
			shadowY: 2 * x, shadowBlur: 8 * x, shadowColor: "rgba(0,0,0,0.25)", y: 54 * x
		content = new Layer
			parent: cardContainer
			backgroundColor: null
			width: card.width, height: card.height
		activity = new TextLayer
			parent: content
			text: "Received an excellent rating"
			width: card.width - 80 * x, x: 40 * x, y: 40 * x
			color: darkblue, fontFamily: "Roboto Condensed", fontWeight: 300, fontSize: 36 * x, lineHeight: 1.5
		emp = new Layer
			parent: content
			width: card.width, height: 210 * x, backgroundColor: null
			y: 94 * x
		empPic = new Layer
			parent: emp
			backgroundColor: null
			size: 90 * x, x: 40 * x, y: 40 * x
			image: e.picture
		empName = new TextLayer
			parent: emp
			x: 170 * x, y: 40 * x, width: 170 * x
			autoSize: true
			text: e.name
			color: darkblue, fontFamily: "Roboto Condensed", fontWeight: 100, fontSize: 56 * x, lineHeight: 1.5
		empRole = new TextLayer
			parent: emp
			color: darkblue, fontFamily: "Roboto Condensed", fontWeight: 100, fontSize: 36 * x, lineHeight: 1.5
			text: e.role + " /"
			x: 170 * x, y: 110 * x
			autoSize: true
		empRate = new Layer
			parent: emp
			width: 108 * x, height: 28 * x, x: empRole.maxX + 16 * x, y: 120 * x
			image: "images/emp_stars.png"
		
		cards.push(card)
	
# 	Set some new variables for the created cards
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
	
	# # Animation
	moveCards = () ->
		if  index < cardCount - 1 - cardSet
			nextPage = cards[cardCount - 1 - cardSet - index]
			lastPage = cards[cardCount - 1 - cardSet - index + cardSet]
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
