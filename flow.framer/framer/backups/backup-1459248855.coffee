{TextLayer} = require 'TextLayer'

bg = new BackgroundLayer backgroundColor: "#f0ede7"

listItems = [
	{
		name:"Minimale informatie",
		count: 0
	},
	{
		name:"Aanvullende informatie"
		count: 5
	},
	{
		name:"Optionele informatie"
		count: 15
	}
]

items = []

listItemW = Screen.width - 80
listItemH = 140
listItemP = 2

expandH = 500

list = new ScrollComponent
	width: Screen.width
	height: Screen.height

list.scrollHorizontal = false

list.content.backgroundColor = null

for i,listitem of listItems
	
# 	Make list item/white bar
	item = new Layer
		name: "item" + i
		parent: list.content
		width: listItemW
		height: listItemH
		y: (listItemH + listItemP) * i + 40
		backgroundColor: null
	item.centerX()
	
# 	Make background
	itemBg = new Layer
		name: "itemBg" + i
		parent: item
		width: listItemW
		height: listItemH
		backgroundColor: "#fff"
		shadowY: 2
		shadowColor: "rgba(197,194,190,1)"
		
# 	Create a title
	title = new Layer
		name: "title" + i
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
	count = new TextLayer
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
		"line-height": "54px"
		"text-align": "center"
	
	itemBg.states.add
		collapsed:
			height: listItemH
		expanded:
			height: expandH
	
	items.push(item)

for i in items
	i.on Events.Click, (event, layer) ->
		layer.animate
			properties:
				height: expandH
	
	
				