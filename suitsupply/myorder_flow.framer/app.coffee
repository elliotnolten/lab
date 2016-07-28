bg = new BackgroundLayer backgroundColor: "#f0ede7"

todoW = Screen.width * 0.5
print Utils.isMobile()
if Utils.isMobile()
	print "is mobile"
	todoW = Screen.width * 0.9
todoH = todoW / 5
todoP = 20
todoListH = Screen.height
todoN = Utils.randomNumber(5,50)
expandW = todoW + 40
expandH = todoH * 2
animationT = 0.2
curve = "spring(400,35,10)"
sum = 0

Framer.Defaults.Animation =
# 	curve: "cubic-bezier(.87,-.41,.19,1.44)"
	curve: curve
	time: animationT

todos = []
todoYs = []
todoExps = []
todoIns = []
added = []

todoList = new ScrollComponent width: Screen.width, height: todoListH, backgroundColor: null, clip: false
todoList.centerX()
todoList.scrollHorizontal = false
todoList.contentInset = top: 80
todoList.content.clip = false

# Create todos
for i in [0...todoN]
	todo = new Layer width: todoW, height: todoH, y: (todoH + todoP) * i, parent: todoList.content, backgroundColor: null
	todo.centerX()
	
	todoBg = new Layer
		name: "bg"
		parent: todo
		width: todo.width, height: todo.height
		backgroundColor: "white"
	
	todos.push(todo)
	todoYs.push(todo.y)
	todoExps.push(false)
	todoIns.push(todo.index)
	
	btn = new Layer parent: todo, width: todo.width * 0.2, height: todo.width * 0.1, maxX: todoBg.width - 10, maxY: todoBg.height - 10, html: "add", name: "btn"
	btn.style = 
		"text-align": "center"
		"line-height": "#{btn.height}px"
	btn.sendToBack()
	added.push(false)

# Create floating basket
basket = new Layer width: 80, height: 80, maxX: Screen.width - 40, maxY: Screen.height - 40, backgroundColor: null

basketBg = new Layer parent: basket, width: basket.width, height: basket.height, borderRadius: 40

basketSum = new Layer parent: basket, width: basket.width, height: basket.height, backgroundColor: null, html: sum
basket.style =
	"text-align": "center"
	"line-height": "#{basket.height}px"

# Function to add item to basket
# Pop the circle
popOutBasket = new Animation
	layer: basketBg
	properties:
		scale: 1.2
		backgroundColor: "red"
	curve: curve
popInBasket = popOutBasket.reverse()

popOutBasket.onAnimationDidStart ->
	Utils.delay 0.1, ->
		popInBasket.start()

# Function to find the index of an item
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
	todoList.height = todoListH + expandH
	
	# Show button
	layer.children[1].bringToFront()
	
# Function for collapsing an item
collapseItem = (layer,i) ->
	# First shrink the with and hide the button
	layer.children[0].animate properties: scaleX: 1
	layer.children[1].sendToBack()
	# Second collapse the height and move it back to original place
	layer.children[0].animate
		properties: height: todoH
		delay: animationT
	layer.animate
		properties: y: todoYs[i]
		delay: animationT
	# And shrink shadow
	layer.children[0].animate
		properties: shadowY: 0, shadowBlur: 0, shadowColor: "rgba(49,49,47,0.25)"
	todoList.height = todoListH

# A function that changes all other items which are not clicked
changeOthers = (array, cI) ->
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

# Loop through all items
for todoItem in todos
	# When you click on an item
	todoItem.children[0].onClick ->
		todoWrap = @parent
		# Find the index of the item that is clicked
		cI = findIndex(todoWrap,todos)
		# What should the clicked item do?
		# If it's not expanded
		if !todoExps[cI]
			# Change expand status of this to "true"
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
		
		# What should all the other items do?
		changeOthers(todos,cI)
		
	
	todoItem.children[1].onClick ->
		todoWrapper = @parent
		currentI = findIndex(todoWrapper,todos)
		# If its parent is expanded
		if todoExps[currentI]
			# And if this item is not yet added
			popOutBasket.start()
			if not added[currentI]
				# Increment the basket sum by 1
				sum += 1
				added[currentI] = true
				basketSum.html = sum
				@html = "remove"
			# If the item is added
			else
				# Decrement the basket sum by 1
				sum -= 1
				added[currentI] = false
				basketSum.html = sum
				@html = "add"
			# When the basket Animation is done
			popInBasket.onAnimationStart ->
				# Collapse the item
				collapseItem(todoWrapper,currentI)
				changeOthers(todos,currentI)
				
