{Item,Look,Button} = require "suitsupply"

look = new Look
	width: Screen.width
	height: Screen.height /2
	backgroundColor: 'white'

cols = 4
rows = 5

for i in [0...cols * rows]
	column = i % cols
	row = i % rows
	print row
	button = new Button
		look: look
		y: look.maxY + 210 * row
		x: column * 210
		name: "item#{i+1}"
		html: "item#{i+1}"