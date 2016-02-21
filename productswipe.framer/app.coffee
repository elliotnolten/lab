# Import modules
$ = require("npm").jquery
TextLayer = require("TextLayer")

bg = new BackgroundLayer backgroundColor: "#f0ede7"

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
# 	Create drage area
	drag = new Layer
		width: Screen.width, height: Screen.height
		backgroundColor: "#f0ede7"
		
	drag.draggable.enabled = true
	drag.draggable.vertical = false
	drag.draggable.constraints = drag
	drag.draggable.bounceOptions =
		friction: 30
		tension: 500
	drag.originX = 0.5
	drag.originY = 1
	drag.index = 0
	
	$.each data.products,(i,e) ->
		ean = e.ean
		eans.push(ean)
		titles.push(e.title)
			
		card = new Layer
			width: Screen.width - 64, height: Screen.width - 64
			clip: false
			backgroundColor: null
		card.centerX()
		card.centerY(-100 - i * 12)
		card.scale = 1 - i * 0.01
		card.index = count - i
		
		if i > 0
			card.rotationZ = 10 * Utils.randomNumber()
			card.blur = 2
		
		image = new Layer
			parent: card
			image: e.images[4].url
			width: card.width, height: card.height
			borderRadius: 32
		image.center()
		
		gradient = new Layer
			parent: image
			width: image.width, height: image.height
		gradient.style =
			"background": "linear-gradient(120deg,rgba(255,255,255,0.25),rgba(255,255,255,0))"
		
		allCards.push(card)
		allCardsXpos.push(card.x)
		
# 		Do the following thing with the card on top
		if i is 0
			card.originY = 5
			image.shadowY = 16
			image.shadowBlur = 32
			image.shadowColor = "rgba(0,0,0,0.5)"
			image.style =
				"box-shadow": "0 -2px 1px rgba(255,255,255,0.25)"
							
			drag.on "change:x", ->
				offset = drag.draggable.offset.x
				rotationZ = Utils.modulate offset, [-200,200], [-10,10]
				card.rotationZ = rotationZ
# 				print Math.abs(offset)
				if Math.abs(offset) > 50
					image.animate
						properties:
							scale: 0.8
						curve: "spring(500,30,10)"
			
			drag.on Events.TouchEnd, ->
				image.animate
					properties:
						scale: 1
					curve: "spring(500,30,10)"
				
		
	title.text = titles[0]