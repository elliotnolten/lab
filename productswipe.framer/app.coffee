# Import modules
$ = require("npm").jquery
TextLayer = require("TextLayer")

bg = new BackgroundLayer backgroundColor: "#f0ede7"

# Set-up PageComponent
page = new PageComponent
  width: Screen.width, height: Screen.width
  scrollVertical: false, clip: false
 page.centerY(-120)

title = new TextLayer
	width: page.width
	textAlign: "center"
	fontSize: 48
	color: "#31312f"
	text: ""
	fontWeight: 300
	height: 200
title.centerY(page.width / 2 + 50)

eans = []
titles = []

feed = $.ajax
	url: "http://nolten.co/bolcomapi.php/lists/limit=20"
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
			backgroundColor: null
			width: page.width, height: page.width 
			x: page.width * i, superLayer: page.content
			clip: false
	
		cardContent = new Layer
			superLayer: card
			backgroundColor: "#fff", borderRadius: 32
			width: card.width - 64, height: card.height
		cardContent.centerX()
		cardContent.style =
			"box-shadow": "0 16px 32px rgba(49,49,47,0.25)"
		
		image = new Layer
			superLayer: cardContent
			image: e.images[4].url
			width: cardContent.width, height: cardContent.height
		image.center()
	
	title.text = titles[0]

	page.on "change:currentPage", ->
		pageIndex = page.horizontalPageIndex(page.currentPage)
		title.text = titles[pageIndex]
		page.previousPage.animate
			properties: 
				scale: 0.8
			time: 0.4
		
		page.currentPage.animate
			properties: 
				scale: 1
			time: 0.4