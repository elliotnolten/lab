# Setup scene
# Require jQuery
$ = require("npm").jquery

# Require TextLayer
TextLayer = require("TextLayer")

# Device
# deviceType can be either "phone" or "desktop"
x = Screen.height / 3840
Framer.DeviceView.Devices["tv"] =
	"deviceType": "phone"
	"screenWidth": 1080 * x
	"screenHeight": 3840 * x

# Set custom device
Framer.Device.deviceType = "tv"

screenMidX = Screen.width / 2
screenMidY = Screen.height / 2

darkblue = "#183051"

# Dark blue background
bg = new BackgroundLayer backgroundColor: darkblue

# Insert Roboto Condensed font
Utils.insertCSS("@import url(https://fonts.googleapis.com/css?family=Roboto+Condensed:100);")
Utils.insertCSS("body {-webkit-font-smoothing: antialiased; -moz-osx-font-smoothing: grayscale;}")

# Store image
store = new Layer
	width: 1080 * x, height: 2272 * x
	image: "images/amsterdam_store.jpg"
storeGrad = new Layer
	width: store.width, height: store.height / 2, maxY: store.maxY
storeGrad.style.background = "-webkit-linear-gradient(top, transparent 0%, #183051 100%)"
	

# Store name
storeName = new TextLayer
	text: "AMSTERDAM"
	fontFamily: "Roboto Condensed"
	color: "#fff"
	fontSize: 120 * x
	fontWeight: 100
	autoSize: true
	x: 70 * x, y: 1640 * x

# Activity timeline

# Variables
delayemp = 4
springemp = "cubic-bezier(.75,.01,.25,1)"
cardWemp = 940 * x
cardHemp = 354 * x
cardPemp = 80 * x
cards = []
cardSet = 4

reviewsHolder = new Layer
	width: cardWemp, height: (cardHemp + cardPemp) * cardSet + 80 * x, clip: true, backgroundColor: null, x: 70 * x, y: 1980 * x

reviews = new PageComponent
	parent: reviewsHolder
	width: reviewsHolder.width, height: cardHemp
	backgroundColor: null, clip: false
reviews.scrollHorizontal = false
reviews.content.backgroundColor = null

reviews.centerX()

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
	
	
	# Create cards
	$.each data,(i,e) ->
		card = new Layer
			parent: reviews.content
			width: cardWemp, height: cardHemp, y: (i - 1) * (cardHemp + cardPemp)
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
			text: "1 hour ago"
			color: "#fff", fontFamily: "Roboto Condensed", fontWeight: 100, fontSize: 36 * x, lineHeight: 1, textAlign: "right"
			maxX: icClock.x - icClock.width
		cardContainer = new Layer
			parent: card
			width: card.width, height: 304 * x
			backgroundColor: "rgba(255,255,255,0.9)"
			scale: 0.5, opacity: 0.2
			borderRadius: 8 * x
			shadowY: 2 * x, shadowBlur: 8 * x, shadowColor: "rgba(0,0,0,0.25)", y: 54 * x
		content = new Layer
			parent: cardContainer
			backgroundColor: null
			width: card.width, height: card.height
		activity = new TextLayer
			parent: content
			text: "Willem from Wormerveer rated " + e.name + " with Excellent"
			width: card.width - 80 * x, x: 40 * x, y: 40 * x
			color: darkblue, fontFamily: "Roboto Condensed", fontWeight: 100, fontSize: 36 * x, lineHeight: 1.5
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
			lastPage = cards[cardCount - 1 - cardSet - index + cardSet]
			reviews.snapToPage(nextPage,true,animationOptions = curve: springemp)
			transformChild(nextPage,springemp)
			lastPage.sendToBack()
			lastPage.animate
				properties:
					y: lastPage.y - (cardHemp + cardPemp)
					opacity: 0
					scale: 0.9
				curve: springemp
			
			index++
		else 
			return

	Utils.interval delayemp, ->
		moveCards()
