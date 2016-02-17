# Import modules
$ = require("npm").jquery
TextLayer = require("TextLayer")

bg = new BackgroundLayer backgroundColor: "#f0ede7"

# Set-up PageComponent
page = new PageComponent
  width: Screen.width, height: Screen.height
  scrollHorizontal: false, clip: false

# Set directionLock and threshold
page.content.draggable.directionLock = true
page.content.draggable.directionLockThreshold = {x:25, y:25}

title = new TextLayer
	width: page.width - 120
	textAlign: "center"
	fontSize: 48
	color: "#31312f"
	text: ""
	fontWeight: 300
	height: 200
title.centerY(page.width / 2 + 50)
title.centerX()

page.index = 1
title.index = 0

eans = []
titles = []
allCards = []

feed = $.ajax
	url: "http://nolten.co/bolcomapi.php/lists/limit=10&ids=3132"
	contentType: "application/jsonp;"
	dataType: "jsonp"
	jsonpCallback: "callback"

feed.done (data) ->
	$.each data.products,(i,e) ->
		ean = e.ean
		eans.push(ean)
		titles.push(e.title)
			
		card = new Layer
			backgroundColor: null
			width: page.width, height: page.height
			y: page.height * i, parent: page.content
			clip: false
	
		cardContent = new Layer
			parent: card
			backgroundColor: "#fff", borderRadius: 32
			width: card.width - 64, height: card.width
			clip: true
		cardContent.centerX()
		cardContent.centerY(-120)
		cardContent.style =
			"box-shadow": "0 16px 48px rgba(49,49,47,0.5)"
		cardContent.draggable.enabled = true
		cardContent.draggable.vertical = false
		cardContent.draggable.constraints = cardContent
		cardContent.draggable.bounceOptions =
			friction: 15
			tension: 300
		
		page.on Events.ScrollStart, ->
			cardContent.draggable.horizontal = false
		page.on Events.ScrollEnd, ->
			cardContent.draggable.horizontal = true
		
		image = new Layer
			parent: cardContent
			image: e.images[4].url
			width: cardContent.width, height: cardContent.height
		image.center()
		
		allCards.push(card)
	
	title.text = titles[0]

	page.on "change:currentPage", ->
		page.previousPage.animate
			properties: 
				scale: 0.8
			time: 0.4
		
		page.currentPage.animate
			properties: 
				scale: 1
			time: 0.4
		
		pageIndex = page.horizontalPageIndex(page.currentPage)
		Utils.delay 0.1, -> title.text = titles[pageIndex]