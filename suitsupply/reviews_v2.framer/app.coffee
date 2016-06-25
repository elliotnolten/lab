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
# Framer.Device.deviceType = "tv"

screenMidX = Screen.width / 2
screenMidY = Screen.height / 2

darkblue = "#183051"

# Dark blue background
bg = new BackgroundLayer backgroundColor: darkblue

# Insert Roboto Condensed font
Utils.insertCSS("@import url(https://fonts.googleapis.com/css?family=Roboto+Condensed:300);")

# Store image
store = new Layer
	width: 1080 * x, height: 2272 * x
	image: "images/store.png"

# Store name
storeName = new TextLayer
	text: "San Francisco, CA"
	fontFamily: "Roboto Condensed"
	color: "#fff"
	fontSize: 120 * x
	fontWeight: 300
	autoSize: true
	x: 70 * x, y: 1640 * x

# Last sold
feats = new Layer
	width: 940 * x, height: 860 * x, x: 70 * x, y: 210 * x, backgroundColor: null

allCards = []
allCardsY = []

feed = $.ajax
	url: "employees.json"
	contentType: "application/json;"
	dataType: "json"
	jsonpCallback: "callback"

feed.error ->
	print feed.statusText
	
feed.done (data) ->
	$.each data,(i,e) ->
		feat = new Layer
			parent: feats
			width: feats.width, height: feats.height, backgroundColor: null
		featShadow = new Layer
			parent: feat
			width: feat.width * 0.9, height: feat.height * 0.9, maxY: feat.maxY + 20 * x
			backgroundColor: "rgba(0,0,0,0.5)", blur: 10
		featCont = new Layer
			parent: feat
			width: feat.width, height: feat.height, backgroundColor: "#fff"
		productImg = new Layer
			parent: featCont
			x: 80 * x, y: 80 * x, width: 220 * x, height: 440 * x
			image: e.item_img
		productTime = new TextLayer
			parent: featCont
			text: "A few seconds ago", autoSize: true
			fontFamily: "Roboto Condensed", fontSize: 36 * x, fontWeight: 300, lineHeight: 1.5
			color: darkblue
			x: 400 * x, y: 80 * x
		productTitle = new TextLayer
			parent: featCont
			autoSizeHeight: true
			text: e.item_title
			fontFamily: "Roboto Condensed", fontSize: 56 * x, fontWeight: 300, lineHeight: 1.25
			color: darkblue
			x: 400 * x, y: 160 * x, width: 460 * x
		productTitle.style = 
			"text-transform": "uppercase"
		productFabric = new TextLayer
			parent: featCont
			text: "PURE LINEN"
			fontFamily: "Roboto Condensed", fontSize: 36 * x, fontWeight: 300, lineHeight: 1.5
			color: "#999"
			x: 400 * x, y: productTitle.maxY + 8 * x
		border = new Layer
			parent: featCont
			width: 780 * x, height: 1, x: 80 * x, y: 600 * x
			backgroundColor: "#d9d9d9"
		
		avatar = new Layer
			parent: featCont
			size: 140 * x, x: 80 * x, y: 640 * x
			image: e.picture
		name = new TextLayer
			parent: featCont
			text: e.name
			fontFamily: "Roboto Condensed", fontSize: 56 * x, fontWeight: 300, lineHeight: 1.5
			color: darkblue
			x: 280 * x, y: 648 * x
		role = new TextLayer
			parent: featCont
			text: e.role + " / Excellent"
			fontFamily: "Roboto Condensed", fontSize: 36 * x, fontWeight: 300, lineHeight: 1.5
			color: darkblue
			autoSize: true
			x: 280 * x, y: 726 * x
		rate = new Layer
			parent: featCont
			width: 108 * x, height: 28 * x, x: 654 * x, y: 738 * x
			image: "images/emp_stars.png"
		
		
		allCards.push(feat)
		allCardsY.push(feat.y)
		
	# A function to update card stack
	updateCards = () ->
			
		allCards.forEach (c,i) ->
			# Hide cards
			if i > 0
				c.opacity = 0
				c.y = -50 * x
				c.scale = 0.9
			
		firstCard = allCards[0]
		firstCard.animate
			properties:
				scale: 1
				rotationZ: 0
				blur: 0
				opacity: 1
				y: 0
			curve: "spring(500,30,10)"
		firstCard.draggable = true
		firstCard.draggable.speedY = 0
		firstCard.draggable.constraints = firstCard
		
		firstCard.onMove (e) ->
# 				print "dragmove"
			delta = this.draggable.constraintsOffset.x
			@.rotationZ = Utils.modulate delta, [-500,500], [-5,5], true
			
		firstCard.on Events.DragEnd, (event) ->
# 				print "dragend"
			endOffset = this.draggable.constraintsOffset.x
			
# 				print "doe het" + endOffset
			
			# if this card is dragged more than 200 pixels, throw it away
			if endOffset >= (200 * x) or endOffset <= (-200 * x)
				this.draggable.bounceOptions = false
				this.draggable.constraints = false
				this.animate
					properties:
						x: this.x * 5
					time: 0
					curve: "ease-in-out"
				this.destroy()
				allCards.shift()
				updateCards()
			
	updateCards()

# Employees

# Variables
delayemp = 4
springemp = "cubic-bezier(.75,.01,.25,1)"
cardWemp = 940 * x
cardHemp = 220 * x
cardPemp = 40 * x
cards = []
cardSet = 6

reviewsHolder = new Layer
	width: cardWemp, height: (cardHemp + cardPemp) * cardSet + 80 * x, clip: true, backgroundColor: null, x: 70 * x, y: 2140 * x

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
		cardContainer = new Layer
			parent: card
			width: card.width, height: card.height
			backgroundColor: null
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
		empName = new TextLayer
			parent: content
			x: 240 * x, y: 54 * x, width: 646 * x
			autoSizeHeight: true
			text: e.name
			color: "#fff", fontFamily: "Roboto Condensed", fontWeight: 300, fontSize: 56 * x, lineHeight: 1.5
		empRole = new TextLayer
			parent: content
			color: "#fff", fontFamily: "Roboto Condensed", fontWeight: 300, fontSize: 36 * x, lineHeight: 1.5
			text: e.role + " / Excellent"
			x: 240 * x, y: empName.maxY + 8 * x
			autoSize: true
		
		empRate = new Layer
			parent: content
			width: 108 * x, height: 28 * x, x: empRole.maxX + 16 * x, y: empRole.y + 12 * x
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
