{Item,Look,Button} = require "suitsupply"
	

look = new Look
	backgroundColor: 'white'
	width: Screen.width
	height: Screen.height /2
look.scrollVertical = false

cols = 4
rows = 5
size = Screen.width / 4

for c in [0...cols]
	for r in [0...rows]
	
		n = r * (rows) + c
		
		button = new Button
			look: look
			size: size
			x: c * size
			y: r * size + look.maxY
			name: "item#{n}"
			html: "item#{n}"