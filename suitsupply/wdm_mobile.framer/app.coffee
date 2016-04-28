# Import file "SS_WDM_v1" (sizes and positions are scaled 1:2)
wdm = Framer.Importer.load("imported/SS_WDM_v1@2x")

Framer.Defaults.Animation =
	curve: "spring(150,20,0)"

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

wdm.showMap.onClick ->
	wdm.sales.animate
		properties: 
			y: Screen.height

wdm.back.onClick ->
	wdm.sales.animate
		properties: 
			y: 0