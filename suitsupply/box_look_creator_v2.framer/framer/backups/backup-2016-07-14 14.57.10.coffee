{Item,Look,Button} = require "suitsupply"

look = new Look
	width: Screen.width
	height: Screen.height /2
	backgroundColor: 'white'

cols = 4
rows = 5

for c in [0...cols]
	for r in [0...rows]
	
		n = r * (rows) + c
		
		button = new Button
			look: look
			x: c * 210
			y: r * 210
			name: "item#{n+1}"
			html: "item#{n+1}"