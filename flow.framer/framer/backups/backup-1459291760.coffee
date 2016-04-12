{TextLayer} = require "TextLayer"

bg = new BackgroundLayer backgroundColor: "#f0ede7"

Framer.Defaults.Animation =
	curve: "spring(400,35,10)"

listItems = [
	{
		name:"Minimale informatie",
		count: 0
		expanded: false
	},
	{
		name:"Aanvullende informatie"
		count: 5
		expanded: false
	},
	{
		name:"Optionele informatie"
		count: 15
		expanded: false
	}
]

items = []
itemYs = []
itemIns = []

listItemW = Screen.width - 80
listItemH = 140
listItemP = 2

expandW = listItemW + 28
scaleW = expandW / listItemW
expandH = 1000

list = new ScrollComponent
	width: Screen.width
	height: Screen.height
	
list.mouseWheelEnabled = true

list.scrollHorizontal = false

list.content.backgroundColor = null

for i,listitem of listItems
	
# 	Make list item/white bar
	item = new Layer
		parent: list.content
		width: listItemW
		height: listItemH
		y: (listItemH + listItemP) * i + 40
		backgroundColor: null
	item.centerX()
	
# 	Make background
	itemBg = new Layer
		parent: item
		width: listItemW
		height: listItemH
		backgroundColor: "#fff"
		shadowY: 2
		shadowColor: "rgba(197,194,190,1)"
		
# 	Create a title
	title = new Layer
		parent: item
		html: listitem.name
		backgroundColor: null
		width: item.width
		height: 42
		x: 42
	
	title.centerY()
	
	title.style =
		"color": "#31312f"
		"font-family": "Open Sans"
		"font-size": "28px"
		"line-height": "42px"
	
# 	Create a count
	count = new Layer
		parent: item
		borderColor: "#ff9233"
		borderWidth: 2
		backgroundColor: null
		height: 54
		html: listitem.count
		width: 70
		borderRadius: 35
		x: item.width - 70 - 42
	
	count.centerY()
	
	count.style =
		"color": "#ff9233"
		"font-family": "Open Sans"
		"font-size": "28px"
		"line-height": "52px"
		"text-align": "center"
	
	itemBg.states.add
		collapsed:
			height: listItemH
		expanded:
			height: expandH
	
	items.push(item)

# Behavior for the array of item layers
for item in items
	itemYs.push(item.y)
	itemIns.push(item.index)
	
	item.onClick ->
		# Track the index of the clicked item
		currentIn = this.index
		currentI = currentIn - 1
		currentY = this.y
		
		# Check if the other itmes come after the clicked one
		for item,i in items
			item.animate
				properties:
					y: itemYs[i]
			item.index = itemIns[i]
			
			if i != currentI
				if listItems[i]["expanded"] == true
					item.children[0].animate
						properties:
							height: listItemH
							scaleX: 1
							borderRadius: 0
							shadowBlur: 0
							shadowY: 2
					listItems[i]["expanded"] = false
			# If they do, move them along with the expansion
			if i > currentI
				currentY = item.y
				item.animate properties: y: currentY + expandH - item.height - 14
		
		
		# Exand animations
		if listItems[currentI]["expanded"] == false
			
			# 0 = itemBg, 1 = title, 2 = count
			
			# Put the clicked item in front
			this.index = 10
			
			# Move the item a little bit up, so it overlaps the previous one
			
			this.animate
				properties:
					y: itemYs[currentI] - 14
			
			# Expand the item background
			this.children[0].animate
				properties:
					height: expandH
					scaleX: scaleW
					borderRadius: 8
					shadowBlur: 28
					shadowY: 14
			
			# Move the title a little bit to the left
			this.children[1].animate
				properties:
					x: this.children[1].x - 14
			
			# Move the count a little bit to the right
			this.children[2].animate
				properties:
					x: this.children[2].x + 14
			
			listItems[currentI]["expanded"] = true
			
			list.height = Screen.height + expandH