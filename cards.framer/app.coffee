$ = require("npm").jquery

screenW = Screen.width

bg = new BackgroundLayer backgroundColor: "white"

count = 5

feed = $.ajax
	url: "http://nolten.co/bolcomapi.php/lists/limit=#{count}&ids=3132"
	contentType: "application/jsonp;"
	dataType: "jsonp"
	jsonpCallback: "callback"

feed.done (data) ->
	
	$.each data.products,(i,e) ->

		card = new Layer
			width: screenW - 128
			height: screenW - 128
			borderRadius: 64
			backgroundColor: "white"
			shadowBlur: 64
			shadowY: 32
			shadowColor: "rgba(0,0,0,0.25)"
			image: e.images[4].url
			scale: 1 - i * 0.025
			index: count - i
			originY: 1
		
		card.centerX()
		card.centerY(-128 - (25 * i))
		
		card.draggable = true
		card.draggable.constraints = card
		card.draggable.vertical = false
		card.draggable.overdragScale = 0.5
		card.draggable.bounceOptions = friction: 30,tension: 600,tolerance: 0.0001
		
		card.onMove ->
			offsetX = this.draggable.constraintsOffset.x
			this.rotationZ = Utils.modulate offsetX, [-200,200], [-7,7], false
			print