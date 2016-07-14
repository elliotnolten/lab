f = 2
curve = "cubic-bezier(.75,.01,.25,1)"

if !Utils.isTouch()
	f = 1

small = 44 * f
big = 108 * f

bg = new BackgroundLayer backgroundColor: "#fff"

rowHolder = new Layer
	width: Screen.width, height: 140 * f, backgroundColor: null

row = new Layer
	parent: rowHolder
	width: rowHolder.width - 20 * f, height: 140 * f, y: 40 * f
	backgroundColor: null
row.centerX()
rowBorder = new Layer
	parent: row, width: row.width, height: f, backgroundColor: "grey", y: row.maxY

toggle = new Layer
	parent: rowHolder
	size: 18 * f, image: "images/expand.png", maxX: row.maxX

rowCol = new Layer
	parent: row
	width: row.width, height: 140 * f
	backgroundColor: null
	originX: 0, originY: 0

itemBaseCol = new Layer
	parent: rowCol
	width: small, height: small * 2
	originX: 0, originY: 0

subItemsCol = new ScrollComponent
	parent: rowCol
	backgroundColor: null
	x: itemBaseCol.maxX
	width: rowCol.width - itemBaseCol.maxX - 20 * f, height: itemBaseCol.height
subItemsCol.scrollVertical = false
subItemsCol.contentInset =
	left: 20 * f
	right: 20 * f

itemSubCols = []
for i in [0...10]
	itemSubCol = new Layer
		parent: subItemsCol.content
		size: small
		x: i * (small + 20 * f), y: itemBaseCol.y
		originX: 0, originY: 0
	itemSubCols.push(itemSubCol)

rowExp = new Layer
	parent: row
	width: row.width, height: 340 * f
	backgroundColor: null
	opacity: 0
	
itemBaseExp = new Layer
	parent: rowExp
	width: big, height: big * 2
	originX: 0, originY: 0

subItemsExp = new ScrollComponent
	parent: rowExp
	backgroundColor: null
	x: itemBaseExp.maxX + 20 * f
	width: rowExp.width - itemBaseExp.maxX - 20 * f, height: itemBaseExp.height
subItemsExp.scrollVertical = false
subItemsExp.contentInset =
	right: 20 * f
subItemsExp.style = "border-left": "1px solid grey"
rowExp.sendToBack()

itemSubExps = []
for i in [0...9]
	itemSubExp = new Layer
		parent: subItemsExp.content
		size: big, x: i * (big + 40 * f)
	itemSubExps.push(itemSubExp)

expanded = false

rowBorder.states.add
	exp:
		y: rowExp.maxY
	col:
		y: rowCol.maxY

# Expanding sequence
scaleUpBase = () ->
	rowExp.bringToFront()
	itemBaseCol.animate
		properties:
			scale: big / small
		time: 0.8
		curve: curve
scaleUpSub = () ->
	for i,l of itemSubCols
		l.animate
			properties:
				scale: big / small
				x: i * (big + 40 * f) + itemBaseExp.maxX
			time: 0.8
			curve: curve
		Utils.delay 0.8, ->
			rowCol.animate
				properties:
					opacity: 0
				time: 0.4
				curve: curve
			rowExp.animate
				properties:
					opacity: 1
				time: 0.4
				curve: curve

# Collapsing sequence
scaleDownBase = () ->
	itemBaseExp.animate
		properties: 
			scale: small / big

toggle.onClick ->
	if expanded is false
		scaleUpBase()
		scaleUpSub()
		expanded = true
	else
		scaleDownBase()
		expanded = false