# Import modules
$ = require("npm").jquery
TextLayer = require("TextLayer")

cardW = Screen.width - 48
cardH = 200

scroll = new ScrollComponent
	width: Screen.width, height: Screen.height, backgroundColor: "#f0ede7"
scroll.scrollHorizontal = false

feed = $.ajax
	url: "http://nolten.co/bolcomapi.php/lists/ids=3132&limit=20"
	contentType: "application/jsonp;"
	dataType: "jsonp"
	jsonpCallback: "callback"
	
feed.success (data) ->
	$.each data.products,(i,e) ->
		card = new Layer
			superLayer: scroll.content
			width: cardW, height: cardH
			y: (cardH + 48) * i + 48
			backgroundColor: "#fff"
			borderRadius: 14
			clip: true
		
		image = new Layer
			superLayer: card
			width: cardH, height: cardH
			image: e.images[4].url
		image.style =
			"border-top-left-radius": "14px"
			"border-bottom-left-radius": "14px"
			
		
		title = new TextLayer
			superLayer: card
			x: 28 + cardH, y: 28
			text: e.title
			color: "#000"
			fontSize: 35
			autoSize: true
			fontFamily: "Open Sans"
			fontWeight: 300
		
		card.centerX()
			