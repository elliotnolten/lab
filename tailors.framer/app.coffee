# Import modules
$ = require("npm").jquery
TextLayer = require("TextLayer")

# set some variables
cardW = Screen.width - 48
cardH = 200

# create a page component
pages = new PageComponent
	width: Screen.width, height: Screen.height
	# No scrolling
	scrollVertical: false
	# The direction lock is enabled to only allow either horizontal or vertical scrolling
	directionLock: true
	
feed = $.ajax
	url: "http://api.randomuser.me/?results=20"
	contentType: "application/json;"
	dataType: "json"
	
feed.done (data) ->
	print data
	$.each data.results,(i,e) ->
		print i * Screen.width
		tailor = new Layer
			width: pages.width - 64, height: pages.height - 64, x: Screen.width * i * 2
			backgroundColor: "#fff", borderRadius: 32
			shadowBlur: 16, shadowColor: "rgba(0,0,0,0.25)", shadowX: 0, shadowY: 16
			superLayer: pages.content
		tailor.center()
		
		tailorName = new TextLayer
			superLayer: tailor
			text: e.name + e.surname
			autoSize: true
			fontSize: 36
			color: "#000"
			fontFamily: "Roboto"
		tailorName.centerX()
			
		