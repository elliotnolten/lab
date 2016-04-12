# Import modules
$ = require("npm").jquery
TextLayer = require("TextLayer")

bg = new BackgroundLayer backgroundColor: "white"

screenMidX = Screen.width / 2
screenMidY = Screen.height / 2

title = new TextLayer
	width: Screen.width - 120
	textAlign: "center"
	fontSize: 48
	color: "#31312f"
	text: ""
	fontWeight: 300
	height: 200
title.centerY(Screen.width / 2 + 50)
title.centerX()

bin = new Layer
	image: "images/bin.pdf"
	width: 24 * 4, height: 28 * 4

heart = new Layer
	image: "images/heart.pdf"
	width: 28 * 4, height: 24 * 4
	x: 100

eans = []
titles = []
allCards = []
allCardsXpos = []

count = 10

feed = $.ajax
	url: "http://nolten.co/bolcomapi.php/lists/limit={count}&ids=3132"
	contentType: "application/jsonp;"
	dataType: "jsonp"
	jsonpCallback: "callback"

feed.done (data) ->
	
	$.each data.products,(i,e) ->
		ean = e.ean
		eans.push(ean)
		titles.push(e.title)
			
		card = new Layer
			name: e.title
			width: Screen.width - 64, height: Screen.width - 64
			clip: false, backgroundColor: null, borderRadius: 32, opacity: 0
		card.centerX()
		card.y = screenMidY - (card.height / 2 + i * 15) - 75
		card.scale = 1 - i * 0.02
		card.index = count - i
		
		if i > 0
			card.rotationZ = 20 * Utils.randomNumber()
			card.blur = 2
		
		image = new Layer
			parent: card
			image: e.images[4].url
			width: card.width, height: card.height
			borderRadius: 32, clip: true
		image.center()
		
		gradient = new Layer
			parent: image
			width: image.width, height: image.height
		gradient.style =
			"background": "linear-gradient(120deg,rgba(255,255,255,0.25),rgba(255,255,255,0))"
		
		allCards.push(card)
		allCardsXpos.push(card.x)
	
	# A function to update card stack
	updateCards = () ->
		title.text = titles[0]
		
		if titles[0] is "undefined"
			title.text = "Done"
			return
			
		allCards.forEach (c,i) ->
			if i isnt 0
				c.animate
					properties:
						scale: 1 - i * 0.05
						y: screenMidY - (c.height / 2 + i * 15) - 75
						opacity: 1
					curve: "spring(500,30,10)"
# 					delay: 1 - i * 0.5
			
		firstCard = allCards[0]
		firstCard.animate
			properties:
				scale: 1
				rotationZ: 0
				blur: 0
				opacity: 1
			curve: "spring(500,30,10)"
		firstCard.draggable = true
		firstCard.draggable.speedY = 0
		firstCard.draggable.constraints = firstCard
		firstCard.shadowBlur = 48
		firstCard.shadowY = 8
		firstCard.shadowColor = "rgba(0,0,0,0.5)"
		firstCardX = firstCard.x
		
		firstCard.onMove (e) ->
# 				print "dragmove"
			delta = this.draggable.constraintsOffset.x
			this.rotationZ = Utils.modulate delta, [-500,500], [-5,5], true		
			
		firstCard.on Events.DragEnd, (event) ->
# 				print "dragend"
			endOffset = this.draggable.constraintsOffset.x
			
			this.animate
				properties:
					rotationZ: 0
					x: firstCardX
				curve: "spring(500,30,10)"
			
# 				print "doe het" + endOffset
			
			# if this card is dragged more than 200 pixels, throw it away
			if endOffset >= 200 or endOffset <= -200
				this.draggable.bounceOptions = false
				this.draggable.constraints = false
				this.animate
					properties:
						x: this.x * 5
					time: 0
					curve: "ease-in-out"
# 					Utils.delay 0.1, ->
# 					print "opnieuw"
				this.destroy()
				allCards.shift()
				titles.shift()
				updateCards()
			
	updateCards()