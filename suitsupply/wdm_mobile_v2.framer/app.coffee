framerKit = require "framerKit"
{TextLayer} = require "TextLayer"

# Styles
small = 
	"font-size": "32px"
	"line-height": "48px"
	"font-family": "Roboto Condensed"
	"color": "white"
	
overlayStyle =
	"-webkit-backdrop-filter": "blur(20px)",
	"background-color":"rgba(255,255,255,0.75)"

if Utils.isChrome()
	overlayStyle =
		"background-color":"rgba(255,255,255,.9)"

# Get roboto font
Utils.insertCSS("@import url(https://fonts.googleapis.com/css?family=Roboto+Condensed:400,300,500);")

# Import file "SS_WDM_v1" (sizes and positions are scaled 1:2)
wdm = Framer.Importer.load("imported/SS_WDM_v1@2x")

Framer.Defaults.Animation =
	curve: "spring(250,30,0)"

fwidth = Framer.Device.screen.width
fheight = Framer.Device.screen.height

statsScroll = ScrollComponent.wrap(wdm.stats)
statsScroll.scrollHorizontal = false
statsScroll.style.backgroundColor = "#183051"
statsScroll.parent = wdm.sales
statsScroll.onScroll ->
	wdm.sales.ignoreEvents = true
statsScroll.sendToBack()

rangeScroll = ScrollComponent.wrap(wdm.range_picker)
rangeScroll.scrollVertical = false
rangeScroll.contentInset = top:32, bottom: 32, left: 24, right: 24
rangeScroll.height = 56 * 2
rangeScroll.y = rangeScroll.y - rangeScroll.height
rangeScrollBg = new Layer
	parent: rangeScroll
	width: rangeScroll.width, height: rangeScroll.height
	backgroundColor: "rgba(255,255,255,0.75)"
rangeScrollBg.sendToBack()
rangeScrollBg.style = overlayStyle

chosenRange = new Layer
	html: "Yesterday, Mon 2016/4/27"
	width: 1000, height: 48
	x: wdm.ic_calendar.maxX + 32
	backgroundColor: null
	parent: wdm.range	
chosenRange.style = small
chosenRange.centerY()

wdm.customRange.style = overlayStyle
	
hideRange = new Animation
	layer: wdm.range
	properties: 
		y: wdm.range.y - wdm.range.height
showRange = hideRange.reverse()

showRangeScroll = new Animation
	layer: rangeScroll
	properties:
		y: rangeScroll.y + rangeScroll.height
hideRangeScroll = showRangeScroll.reverse()

wdm.customRange.opacity = 0

hideCustomRange = new Animation
	layer: wdm.customRange
	properties:
		y: wdm.customRange.y - wdm.customRange.height
showCustomRange = hideCustomRange.reverse()
hideCustomRange.start()

wdm.range.onClick ->
	rangeScroll.opacity = 1
	hideRange.start()

hideRange.onAnimationStart ->
	wdm.range_picker.opacity = 1
	showRangeScroll.start()

wdm.date_custom.onClick ->
	wdm.customRange.opacity = 1
	hideRangeScroll.start()
	showCustomRange.start()

wdm.custom_close.onClick ->
	hideCustomRange.start()
hideCustomRange.onAnimationStart ->
	showRangeScroll.start()

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
	showBack.start()

wdm.back.onClick ->
	hideBack.start()

hideBack.onAnimationStart ->
	Utils.delay 0.3, ->
		showSales.start()

# When sales shows again, scroll back to top
showSales.onAnimationStart ->
	scroll.scrollY = 0

# Choose a preset range
for layer, i in wdm.date_options.subLayers
	if layer.name isnt "date_custom"
		date = ""
		layer.onClick ->
			switch this.name
				when "date_month" then date = "Last month, Sun 2016/03/27 - Wed 2016/04/27"
				when "date_week" then date = "Last week, Wed 2016/04/20 - Wed 2016/04/27"
				when "date_yesterday" then date = "Yesterday, Wed 2016/04/27"
			chosenRange.html = date
			
			hideRangeScroll.start()
			showRange.start()