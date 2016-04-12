bg = new BackgroundLayer backgroundColor: "#f0ede7"

todoW = Screen.width - 80
todoH = 142
todoN = 5
expandW = todoW + 40
expandH = todoH * 2
animationT = 0.2

Framer.Defaults.Animation =
# 	curve: "cubic-bezier(.87,-.41,.19,1.44)"
	curve: "spring(400,35,10)"
	time: animationT

todos = []
todoYs = []
todoExps = []
todoIns = []

todoList = new Layer width: Screen.width, height: (todoH + 2) * todoN, backgroundColor: null, y: 80
todoList.centerX()


# Create todos

for i in [0...todoN]
	todo = new Layer width: todoW, height: todoH, y: (todoH + 2) * i, parent: todoList, backgroundColor: null
	todo.centerX()
	
	todBg = new Layer
		parent: todo
		width: todo.width, height: todo.height
		backgroundColor: "white", shadowY: 2, shadowColor: "rgba(49,49,47,0.25)"

	todos.push(todo)
	todoYs.push(todo.y)
	todoExps.push(false)
	todoIns.push(todo.index)

# Some functions
findIndex = (object,arr) ->
	for i, objects of arr
		return parseInt(i) if object == objects

# Function for expanding an item
expandItem = (layer, i) ->
	# And put it in front
	layer.bringToFront()
	# First widen it
	layer.children[0].animate properties: scaleX: expandW / todoW
	# Second expand height and move it 20 pixels up
	layer.children[0].animate
		properties: height: expandH
		delay: animationT
	layer.animate
		properties: y: todoYs[i] - 20
		delay: animationT
	# And expand shadow
	layer.children[0].animate properties: shadowBlur: 40, shadowY: 10, shadowColor: "rgba(49,49,47,0.5)"
	# And show button
	layer.children[1].animate
		properties: opacity: 1
		delay: animationT * 2

# Function for collapsing an item
collapseItem = (layer,i) ->
	# Hide button
	layer.children[1].animate
		properties: opacity: 0
	# First shrink the with
	layer.children[0].animate properties: scaleX: 1
	# Second collapse the height and move it back to original place
	layer.children[0].animate
		properties: height: todoH
		delay: animationT
	layer.animate
		properties: y: todoYs[i]
		delay: animationT
	# And shrink shadow
	layer.children[0].animate
		properties: shadowY: 2, shadowBlur: 0, shadowColor: "rgba(49,49,47,0.25)"
		
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
							properties: y: todoYs[i - 1] + expandH - 20
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