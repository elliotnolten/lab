# Import file "SS-sales-metric-tool" (sizes and positions are scaled 1:2)
smt = Framer.Importer.load("imported/SS-sales-metric-tool@2x")

dateStyle = 
	"font-family": "Roboto Condensed"
	"text-align": "center"
	"font-size": "32px"
	"font-weight": "300"
	"line-height": "112px"

# Get roboto font
Utils.insertCSS("@import url(https://fonts.googleapis.com/css?family=Roboto+Condensed:400,300,500);")

Framer.Defaults.Animation =
	curve: "spring(250,25,0)"

scroll = ScrollComponent.wrap(smt.scroll)
scroll.directionLock = true
scroll.scrollHorizontal = false

showCustom = new Animation
	layer: smt.custom
	properties:
		y: smt.safari.maxY
hideCustom = showCustom.reverse()

smt.customBtn.onClick ->
	showCustom.start()

smt.date.html = "Week, 4/5/2016 - 11/5/2016"
smt.date.width = smt.employee.width
smt.date.x = 0

smt.date.style = dateStyle

headerDate = smt.date.copy()
headerDate.style = dateStyle
headerDate.height = 56 * 2
headerDate.parent = smt.header
headerDate.y = 0

smt.custom.onClick ->
	hideCustom.start()
	smt.date.html = "Custom, 25/4/2016 - 3/5/2016"

showHeaderName = new Animation
	

scroll.onMove ->
	scrollY = scroll.scrollY
	if scrollY > smt.nav.maxY
		print "show"
	

