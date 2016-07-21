{Item,Look,Button} = require "suitsupply"

lookScroll = new ScrollComponent
	width: Screen.width
	height: Screen.height /2

look = new Look
	parent: lookScroll.content
	backgroundColor: 'white'
	width: lookScroll.width
	height: lookScroll.height

cols = 4
rows = 5

for c in [0...cols]
	for r in [0...rows]
	
		n = r * (rows) + c
		
		button = new Button
			look: look
			x: c * 210
			y: r * 210 + look.maxY
			name: "item#{n}"
			html: "item#{n}"