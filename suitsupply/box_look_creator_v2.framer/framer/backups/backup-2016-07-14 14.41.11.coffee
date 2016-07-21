{Item,Look,Button} = require "suitsupply"

look = new Look
	width: Screen.width
	height: Screen.height /2
	backgroundColor: 'white'

cols = 4

for i in [0...cols * 2]
	column = i % cols
	row = 0
	if i > cols - 1
		row = 1
	print row
	button = new Button
		look: look
		y: look.maxY + 210 * row
		x: column * 210
		name: "item#{i+1}"
		html: "item#{i+1}"