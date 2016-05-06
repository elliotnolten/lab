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

wdm.rangeWrap.bringToFront()

# chooseRange
crBg = new Layer
	parent: wdm.chooseRange
	width: wdm.chooseRange.width, height: wdm.chooseRange.height
	backgroundColor: "#3376C9"
wdm.chooseRangeBg.destroy()
crBg.sendToBack()
crH = wdm.chooseRange.height
crYstart = wdm.chooseRange.y
crYend = wdm.header.maxY - wdm.chooseRange.height

# Make rangePicker scrollable
rangeScroll = ScrollComponent.wrap(wdm.dateOptions)
rangeScroll.scrollVertical = false
rangeScroll.contentInset = left: 48, right: 48, top: 48, bottom: 48
rangeScroll.height = 144

rangeBg = new Layer
	width: rangeScroll.width, height: rangeScroll.height
	y: -144
	parent: wdm.rangeWrap
rangeBg.style = overlayStyle
rangeBg.sendToBack()

customRangeBg = new Layer
	width: wdm.customRange.width + 96, height: wdm.customRange.height + 192
	y: -(wdm.customRange.height + 192)
	parent: wdm.rangeWrap
customRangeBg.style = overlayStyle
customRangeBg.placeBefore(rangeBg)

wdm.rangePicker.states.add
	show: y: 0
rangeBg.states.add
	show: y: 0


wdm.chooseRange.onClick ->
	wdm.rangePicker.states.next()
	rangeBg.states.next()

wdm.customRange.states.add
	show: y: 96
customRangeBg.states.add
	show: y: 0

wdm.dateCustom.onClick ->
	wdm.rangePicker.states.next()
	rangeBg.states.next()
	Utils.delay 0.5, ->
		wdm.customRange.states.next()
		customRangeBg.states.next()

wdm.customClose.onClick ->
	wdm.customRange.states.next()
	customRangeBg.states.next()
	Utils.delay 0.5, ->
		wdm.rangePicker.states.next()
		rangeBg.states.next()

wdm.customSubmit.onClick ->
	wdm.customRange.states.next()
	customRangeBg.states.next()