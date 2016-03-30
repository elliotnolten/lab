bg = new BackgroundLayer backgroundColor: "#f0ede7"

listItems = ["Minimal informatie","Aanvullende informatie","Optionele informatie"]

for i,listitem of listItems
	item = new Layer
		width: Screen.width - 80
		height: 140
		backgroundColor: "#fff"
		borderRadius: 8
		shadowY: 2
		shadowColor: "rgba(49,49,47,0.25)"
		
	title = new Layer
		parent: item