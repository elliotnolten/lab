f = 1

bg = new BackgroundLayer backgroundColor: "#fff"
lookArea = new Layer
	backgroundColor: "#F4F6F9"
	width: Screen.width, height: 302 * f

lookItems = []
items = []
for i in [0...6]
	xDist = i % 3
	print xDist
	item = new Layer
		size: 150 * f
		x: xDist * 200 * f, y: lookArea.maxY + 100 + 3 * i
		backgroundColor: Utils.randomColor(0.5)
	items.push(item)
	
# 	lookItem = item.copy()
# 	lookItem.parent = lookArea
# 	lookItem.y = 100
# 	lookItem.scale = 0
# 	lookItems.push(lookItem)

# Check looksArea
createLook = () ->
	print "create look"

for i, item of items
	item.onTouchStart ->
		@.animate
			properties:
				scale: 0.8
			curve: "spring(800,20,0)"
	item.onTouchEnd ->
		thisIndex = items.indexOf(@)
		@.animate
			properties:
				scale: 1
			curve: "spring(800,20,0)"
		
		