# Import file "feedback" (sizes and positions are scaled 1:2)
sketch = Framer.Importer.load("imported/feedback@2x")

bg = new BackgroundLayer backgroundColor: "white"

sketch.tooltip.scale = 0.8
sketch.tooltip.opacity = 0

sketch.tooltip.originX = 0
sketch.tooltip.originY = 0

sketch.tooltipMsg.opacity = 0

sketch.custom.opacity = 0
sketch.custom.y = Screen.height - sketch.custom.height + 100
sketch.google.destroy()

sketch.pilotBtn.y = Screen.height - sketch.pilotBtn.height

mouse = (layer) ->
# 	layer.onMouseOver -> this.style.cursor = "pointer"
# 	layer.onMouseOut -> this.style.cursor = "default"

mouse(sketch.tooltip)
mouse(sketch.pilotBtn)
mouse(sketch.close)
mouse(sketch.highlight)

scroll = new ScrollComponent
	width: Screen.width, height: Screen.height
scroll.scrollHorizontal = false

sketch.enrichguioo.parent = scroll.content
sketch.highlight.parent = scroll.content
sketch.tooltip.parent = scroll.content
sketch.enrichment.index = 100

grey = new Layer
	width: Screen.width, height: 1700, y: 350
	backgroundColor: "#f0ede7"
	parent: scroll.content
	index: 0
	
# Standard bounce curve
bounceCurve = "spring(700,40,10)"
	
# The states of the tooltip
sketch.tooltip.states.add
	expanded:
		scale: 1
		opacity: 1
	contracted:
		scale: 0.8
		opacity: 0

sketch.tooltip.states.animationOptions =
	curve: bounceCurve

sketch.tooltip.states.switch("expanded")

# The states of the pilotBtn
sketch.pilotBtn.states.add
	offCanvas:
		y: Screen.height
	onCanvas:
		y: Screen.height - sketch.pilotBtn.height

sketch.pilotBtn.states.animationOptions =
	curve: bounceCurve

# The states of the form
sketch.custom.states.add
	appear:
		opacity: 1
		y: Screen.height - sketch.custom.height
	disappear:
		opacity: 0
		y: Screen.height - sketch.custom.height + 100

sketch.custom.states.animationOptions = 
	curve: bounceCurve

sketch.tooltip.onClick ->
	this.states.next()
	Utils.delay 0.5, ->
		sketch.pilotBtn.states.switch("offCanvas", curve: "ease-in-out", time: 0.2)
		Utils.delay 0.1, ->
			sketch.custom.states.switch("appear")

sketch.close.onClick ->
	sketch.custom.states.switch("disappear", curve: "ease-in-out", time: 0.2)
	Utils.delay 0.5, ->
		sketch.pilotBtn.states.switch("onCanvas")

sketch.pilotBtn.onClick ->
	sketch.pilotBtn.states.switch("offCanvas")
	Utils.delay 0.2, ->
		sketch.tooltip.states.switch("contracted")
		sketch.custom.states.switch("appear")

sketch.highlight.onClick ->
	sketch.tooltip.states.switch("expanded")


