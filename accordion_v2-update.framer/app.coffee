Framer.DeviceView.Devices["dribbble"] =
	"deviceType": "desktop"
	"screenWidth": 800
	"screenHeight": 600
	"deviceImageWidth": 800
	"deviceImageHeight": 600
# Set custom device
Framer.Device.deviceType = "dribbble"

gradients = JSON.parse Utils.domLoadDataSync "https://raw.githubusercontent.com/Ghosh/uiGradients/master/gradients.json"

colorSets = []

for i,val of gradients
	colorSets.push(val.colors.join(","))

randColorSet = Utils.randomChoice(colorSets)

bg = new Layer width: Screen.width, height: Screen.height
bg.style =
	"background": "linear-gradient(to bottom left, #{randColorSet})"

todoN = 4
todoP = 20
todoW = Screen.width * 0.5
todoH = (Screen.height * 0.6) / todoN - todoP
expandW = todoW * 1.2
expandH = todoH * 3
animationT = 0.2
borderRadius = 4

Framer.Defaults.Animation =
# 	curve: "cubic-bezier(.87,-.41,.19,1.44)"
	curve: "spring(400,35,10)"
	time: animationT

todos = []
todoYs = []
todoExps = []
todoIns = []

todoList = new Layer width: Screen.width, height: (todoH + 2) * todoN, backgroundColor: null
todoList.centerY(-20)


# Create todos
for i in [0...todoN]
	todo = new Layer width: todoW, height: todoH, y: (todoH + todoP) * i, parent: todoList, backgroundColor: null
	todo.centerX()
	
	todBg = new Layer
		parent: todo
		width: todo.width, height: todo.height
		backgroundColor: "white", borderRadius: borderRadius, opacity: 0.5
	
	todos.push(todo)
	todoYs.push(todo.y)
	todoExps.push(false)
	todoIns.push(todo.index)

# Some functions
# Function to find the index of an object in its array
findIndex = (object,arr) ->
	for i, objects of arr
		return parseInt(i) if object == objects

# Function for expanding an item
expandItem = (layer, i) ->
	# And put it in front
	layer.bringToFront()
	# First widen it
	layer.children[0].animate properties: width: expandW, x: (todoW - expandW) / 2
	# Second expand height and move it 20 pixels up
	layer.children[0].animate
		properties: height: expandH, y: (todoH - expandW) / 8
		delay: animationT
	layer.animate
		properties: y: todoYs[i] - todo
		delay: animationT
	# And expand shadow
	layer.children[0].animate properties: shadowBlur: 40, shadowY: 10, shadowColor: "rgba(49,49,47,0.5)", opacity: 1
	
# Function for collapsing an item
collapseItem = (layer,i) ->
	# First shrink the with
	layer.children[0].animate properties: width: todoW, x: 0
	# Second collapse the height and move it back to original place
	layer.children[0].animate
		properties: height: todoH, y: 0
		delay: animationT
# 	layer.animate
# 		properties: y: todoYs[i]
# 		delay: animationT
	# And shrink shadow
	layer.children[0].animate
		properties: shadowY: 0, shadowBlur: 0, opacity: 0.5
		delay: animationT
		
# Loop through all items
for todoItem in todos
			
	todoItem.children[0].onClick ->
		todoWrap = this.parent
		cI = findIndex(todoWrap,todos)
		# What should the clicked item do?
		# If it's not expanded
		if !todoExps[cI]
			# Change expand status of this is "true"
			todoExps[cI] = true
		# If it is expanded
		else if todoExps[cI]
			# Change expand status to "false"
			todoExps[cI] = false
		
		# If clicked item is expanding (todoExps == true)
		if todoExps[cI]
			# Expand it
			expandItem(todoWrap,cI)
			
		
		# If clicked item is collapsing (todoExps == false)
		if !todoExps[cI]
			# Collapse it
			collapseItem(todoWrap,cI)
		
		# Loop trough all items
		for n,item of todos
			i = parseInt(n)
			# What should the not-clicked items do?
			if i != cI
				# Set the index back to original
				item.index = todoIns[i]
				# If the item is below the clicked item
				if i > cI 
					# If the clicked item is expanding
					if todoExps[cI]
						# Move it down with a delay
						item.animate
							properties: y: todoYs[i - 1] + expandH - todoH
							delay: animationT
					# If the clicked item is collapsed
					else if !todoExps[cI]
						# Move it back up with a delay
						item.animate
							properties: y: todoYs[i]
							delay: animationT
					# If the item is expanded
					if todoExps[i]
						# Collapse it
						collapseItem(item)
						todoExps[i] = false
				
				# If the item is above the clicked item
				if i < cI
					# Move all items back to original position
					item.animate
						properties: y: todoYs[i]
						delay: animationT
					# If the item is expanded
					if todoExps[i]
						# Collapse it
						collapseItem(item)
						todoExps[i] = false
