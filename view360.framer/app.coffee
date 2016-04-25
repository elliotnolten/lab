bg = new BackgroundLayer backgroundColor: "#fff"

shirt = new Layer
	width: Screen.width, height: Screen.height, backgroundColor: null

shirt.onSwipe (e) ->
	print e.deltaX
