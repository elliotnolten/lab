Framer.Device.deviceScale = 1
# Default cursor
document.body.style.cursor = "default"

# Import file "feedback"
sketch = Framer.Importer.load("imported/feedback@1x")

sketch.tooltip.scale = 0.8
sketch.tooltip.opacity = 0

sketch.tooltip.originX = 0
sketch.tooltip.originY = 0

sketch.tooltipMsg.opacity = 0

sketch.google.opacity = 0
sketch.google.y = Screen.height - sketch.google.height + 100
sketch.custom.destroy()

sketch.gclose.index = 10

sketch.pilotBtn.y = Screen.height - sketch.pilotBtn.height

mouse = (layer) ->
	layer.onMouseOver -> this.style.cursor = "pointer"
	layer.onMouseOut -> this.style.cursor = "default"

mouse(sketch.tooltip)
mouse(sketch.pilotBtn)
mouse(sketch.gclose)
mouse(sketch.highlight)
	
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
sketch.google.states.add
	appear:
		opacity: 1
		y: Screen.height - sketch.google.height
	disappear:
		opacity: 0
		y: Screen.height - sketch.google.height + 100

sketch.google.states.animationOptions = 
	curve: bounceCurve

sketch.tooltip.onClick ->
	this.states.next()
	Utils.delay 0.5, ->
		sketch.pilotBtn.states.switch("offCanvas", curve: "ease-in-out", time: 0.2)
		Utils.delay 0.1, ->
			sketch.google.states.switch("appear")

sketch.gclose.onClick ->
	sketch.google.states.switch("disappear", curve: "ease-in-out", time: 0.2)
	Utils.delay 0.5, ->
		sketch.pilotBtn.states.switch("onCanvas")

sketch.pilotBtn.onClick ->
	sketch.pilotBtn.states.switch("offCanvas")
	Utils.delay 0.2, ->
		sketch.tooltip.states.switch("contracted")
		sketch.google.states.switch("appear")

sketch.highlight.onClick ->
	sketch.tooltip.states.switch("expanded")


