# Import modules
$ = require("npm").jquery
TextLayer = require("TextLayer")

# Set-up PageComponent
page = new PageComponent
  width: Screen.width, height: Screen.height
  y: 128, scrollVertical: false

eans = []

feed = $.ajax
	url: "http://nolten.co/bolcomapi.php/lists/retailid=12554&limit=50"
	contentType: "application/jsonp;"
	dataType: "jsonp"
	jsonpCallback: "callback"

feed.done (data) ->
	$.each data.products,(i,e) ->
		ean = e.ean
		eans.push(ean)
			
		card = new Layer
			name: e.title
			backgroundColor: null
			width: page.width, height: 1040 
			x: page.width * i, superLayer: page.content
	
		cardContent = new Layer
			superLayer: card
			backgroundColor: "#fff", borderRadius: 8
			width: card.width - 64, height: card.height
		cardContent.centerX()
		
		image = new Layer
			superLayer: cardContent
			image: e.images[4].url
			width: cardContent.width - 120, height: cardContent.height - 120
		image.center()

page.on "change:currentPage", ->
	page.previousPage.animate
		properties:
			scale: 0.75
			time: 0.2
	page.previousPage.once Events.AnimationEnd, ->
		this.scale = 1