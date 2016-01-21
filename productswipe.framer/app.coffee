# Import modules
$ = require("npm").jquery
TextLayer = require("TextLayer")

# Set-up PageComponent
page = new PageComponent
  width: Screen.width, height: Screen.height
  y: 128, scrollVertical: false

feed = $.ajax
	url: "http://nolten.co/bolcomapi.php/lists/retailid=12554&limit=5"
	contentType: "application/jsonp;"
	dataType: "jsonp"
	jsonpCallback: "callback"

feed.done (data) ->
	$.each data.products,(i,e) ->
		card = new Layer 
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
	