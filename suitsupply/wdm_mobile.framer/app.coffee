# Import file "SS_WDM_v1" (sizes and positions are scaled 1:2)
wdm = Framer.Importer.load("imported/SS_WDM_v1@2x")

Framer.Defaults.Animation =
	curve: "spring(250,30,0)"

fwidth = Framer.Device.screen.width
fheight = Framer.Device.screen.height

scroll = ScrollComponent.wrap(wdm.stats)
scroll.scrollHorizontal = false

wdm.map.draggable.enabled = true
wdm.map.draggable.constraints =
	x:-(wdm.map.width-fwidth)
	y:-(wdm.map.height-fheight)
	width: (wdm.map.width*2)-fwidth
	height: (wdm.map.height*2)-fheight
wdm.map.pinchable.enabled = true

wdm.back.minY = 1110

hideSales = new Animation
	layer: wdm.sales
	properties:
		y: Screen.height
showSales = hideSales.reverse()

hideBack = new Animation
	layer: wdm.back
	properties: 
		minY: Screen.height
	curve: "ease-in-out"
	time: 0.4
showBack = hideBack.reverse()

wdm.showMap.onClick ->
	hideSales.start()

hideSales.onAnimationEnd ->
# 	Utils.delay 0.2, ->
	showBack.start()

wdm.back.onClick ->
	hideBack.start()

hideBack.onAnimationStart ->
	Utils.delay 0.3, ->
		showSales.start()