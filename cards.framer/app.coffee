screenW = Screen.width

bg = new BackgroundLayer backgroundColor: "white"

card = new Layer
	width: screenW - 128
	height: screenW - 128
	borderRadius: 64
	backgroundColor: "white"
	shadowBlur: 64
	shadowY: 32
	shadowColor: "rgba(0,0,0,0.25)"

card.centerX()
card.centerY(-128)
print card.midX

card.draggable = true
card.draggable.constraints = card
card.draggable.vertical = false

card.on Events.DragMove, ->
	deltaX = card.draggable.constraintsOffset.x	card.rotationZ = Utils.modulate deltaX, [-500,500], [-10,10], true