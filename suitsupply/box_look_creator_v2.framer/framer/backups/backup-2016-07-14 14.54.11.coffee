{Item,Look,Button} = require "suitsupply"

look = new Look
	width: Screen.width
	height: Screen.height /2
	backgroundColor: 'white'

cols = 4
rows = 5

for cols in [0...cols]
	button = new Button
		look: look
		x: cols * 210
		name: "item#{i+1}"
		html: "item#{i+1}"