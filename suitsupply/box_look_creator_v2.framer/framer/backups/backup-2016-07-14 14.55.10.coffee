{Item,Look,Button} = require "suitsupply"

look = new Look
	width: Screen.width
	height: Screen.height /2
	backgroundColor: 'white'

cols = 4
rows = 5

for c in [0...cols]
	button = new Button
		look: look
		x: c * 210
		y: look.maxY
		name: "item#{c+1}"
		html: "item#{c+1}"