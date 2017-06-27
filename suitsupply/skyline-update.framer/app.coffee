# >>> Framer Fold >>>
# Sharing Info
# This info is presented in a widget when you share

Framer.Info =
	title: ""
	description: ""
	author: "Elliot Nolten"
	twitter: ""

# <<< Framer Fold <<<

# All breakpoints
breakpoints = [
	{name: "small portrait", width: 320, height: 480, landscape: false}
	{name: "small landscape", width: 480, height: 320, landscape: true}
	{name: "iPhone 7 portrait", width: 375, height: 667, landscape: false}
	{name: "iPhone 7 landscape", width: 667, height: 375, landscape: true}
	{name: "Facebook Ad", width: 600, height: 600, landscape: true}
	{name: "medium", width: 768, height: 1024, landscape: false}
	{name: "large", width: 1024, height: 768, landscape: true}
	{name: "xlarge", width: 1280, height: 800, landscape: true}
	{name: "xxlarge", width: 1440, height: 900, landscape: true}
	{name: "Full HD", width: 1920, height: 1080, landscape: true}
	{name: "xxxlarge", width: 2560, height: 1440, landscape: true}
]

cities = [ 
	{name: "newyork"}
	{name: "amsterdam"}
	{name: "dallas"}
]

screenW = Screen.width
screenH = Screen.height
allBtn = []
allW = []
allH = []
allLS = []
allTitle = []
allCityToggles = []
x = screenW / 2560

trueFalse = Utils.cycle true, false

if Utils.isPhone() then x = 2

bg = new BackgroundLayer backgroundColor: "#EEE"

vw = new Layer
	width: breakpoints[0].width * x
	height: breakpoints[0].height * x
	x: Align.center
	y: Align.center
	backgroundColor: null

title = new Layer
	html: breakpoints[0].name, backgroundColor: null, x: Align.center, y: Align.top(50), height: 59
title.style =
	"color": "#000"
	"text-align": "center"

toggle = new Layer
	borderRadius: 4, width: 100, height: 50, x: Align.center, y: title.maxY + 25, html: "clip"
toggle.style = 
	"text-align": "center"
	"line-height": "50px"

# City Toggles
for i,c of cities
	cityToggle = new Layer
		width: 100, height: 50, x: toggle.maxX + 20 + 120 * i, y: toggle.y, borderRadius: 4, html: c.name
	cityToggle.style =
		"text-align": "center"
		"line-height": "50px"
	allCityToggles.push(cityToggle)

for i,cityToggle of allCityToggles
	cityToggle.onClick ->
		index = allCityToggles.indexOf(@)
		buildings.image = "images/#{cities[index].name}.png"

btns = new Layer
	width: 54 * breakpoints.length, height: 44, backgroundColor: null, x: Align.center, y: Align.bottom(-48)

for i,bp of breakpoints
	btn = new Layer
		parent: btns, borderRadius: 4, x: ((2560 / 40) + 10) * i
		width: bp.width / 20, height: bp.height / 20
	
	allBtn.push(btn)
	allW.push(bp.width)
	allH.push(bp.height)
	allLS.push(bp.landscape)
	allTitle.push(bp.name)

# Skyline
scaleW = 4
buildingsW = vw.width * scaleW
buildingsH = buildingsW / 3 * 1.5
skyW = buildingsW * 0.75
skyH = vw.height

sky = new Layer
	parent: vw
	width: vw.width * 2, height: vw.height, x: -vw.width / 2
	image: "images/sky.png"

buildings = new Layer
	parent: vw
	width: buildingsW, height: buildingsH
	image: "images/newyork.png"
	x: -(buildingsW - vw.width) / 2
	y: vw.height - buildingsH

buildings.draggable = true
buildings.draggable.constraints =
	x: buildings.x
	y: buildings.y
	width: buildings.width
	height: buildings.height
buildings.draggable.speedY = 0
buildings.draggable.overdragScale = 0.5

borders = new Layer
	parent: vw, width: vw.width, height: vw.height, borderWidth: 1, borderColor: "white", backgroundColor: null, visible: trueFalse()
	
mW = new Layer
	width: vw.width, height: 1, parent: vw, backgroundColor: "white", y: Align.top(10)
mWval = new Layer
	parent: mW, width: mW.width, height: 20, html: breakpoints[0].width, backgroundColor: null, x: 20
mH = new Layer
	parent: vw, width: 1, height: vw.height, backgroundColor: "white", x: 10
mHval = new Layer
	parent: mH, width: 100, height: 20, backgroundColor: null, rotationZ: 270, html: breakpoints[0].height, x: -40, y: 100
mHval.style = "text-align": "center"

mouseMove = new Layer width: screenW, height: screenH, backgroundColor: null

toggle.onClick ->
	truth = trueFalse()
	vw.clip = truth

# Breakpoint switch
for i,btn of allBtn
	btn.onClick ->
		index = allBtn.indexOf(@)
		
		isLS = allLS[index]
		if isLS then scaleW = 1.5 else scaleW = 3
		
		currentW = vw.width
		currentH = vw.height
		newW = allW[index] * x
		newH = allH[index] * x
		newX = (screenW - newW) / 2
		newY = (screenH - newH) / 2
		newMaxY = newY + newH
		newBuildingsW = newW * scaleW
		newBuildingsH = newBuildingsW * (1500 / 3000)
		newSkyW = newBuildingsW * 0.75
		newSkyH = newH
		newBuildingsX =  -(newBuildingsW - newW) / 2
		newBuildingsY = newH - newBuildingsH
		newSkyX = -(newSkyW - newW) / 2
		
		if isLS
			newBuildingsY = (newH - newBuildingsH) + newBuildingsH * 0.1
			if allW[index] >= 1280
				newBuildingsY = (newH - newBuildingsH) + newBuildingsH * 0.05
		
		title.html = allTitle[index]
		
		vw.animate
			properties:
				width: newW
				height: newH
				x: newX
				y: newY
		
		borders.animate
			properties:
				width: newW
				height: newH
		
		sky.animate
			properties:
				x: newSkyX
				width: newSkyW
				height: newH
		
		buildingsAni = new Animation
			layer: buildings
			properties: 
				width: newBuildingsW
				height: newBuildingsH
				x: newBuildingsX
				y: newBuildingsY
		
		buildingsAni.start()
		
		buildingsAni.onAnimationEnd ->
			buildings.draggable.constraints = buildings
		
		mW.animate properties: width: newW
		mWval.html = breakpoints[index].width
		mH.animate properties: height: newH
		mHval.html = breakpoints[index].height

buildingsStart = buildings.minX
buildingsEnd = buildings.maxX
skyStart = sky.minX
skyEnd = sky.maxX

buildings.onDragStart ->
	buildingsStart = buildings.minX
	buildingsEnd = buildings.maxX
	skyStart = sky.minX
	skyEnd = sky.maxX

	
buildings.on "change:x", ->
	sky.x = Utils.modulate buildings.x, [buildingsStart, buildingsEnd], [skyStart, skyEnd], false

