# Import modules
$ = require("npm").jquery
TextLayer = require("TextLayer")

cardW = Screen.width - 48
cardH = 200

scroll = new ScrollComponent
	width: Screen.width, height: Screen.height - 100, backgroundColor: "#f0ede7"
	y: 100
scroll.scrollHorizontal = false
scroll.contentInset =
	top: 48
	bottom: 48

header = new Layer
	width: Screen.width, height: 100, backgroundColor: "#36c"

feed = $.ajax
	url: "http://nolten.co/bolcomapi.php/lists/ids=3132&limit=20"
	contentType: "application/jsonp;"
	dataType: "jsonp"
	jsonpCallback: "callback"

feed.error ->
	print "no products"
	
feed.success (data) ->
	$.each data.products,(i,e) ->
		card = new Layer
			superLayer: scroll.content
			width: cardW, height: cardH
			y: (cardH + 48) * i
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
		
			