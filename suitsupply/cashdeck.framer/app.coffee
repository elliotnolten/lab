# Import file "cashdeck_pilot_visuals"
cd = Framer.Importer.load("imported/cashdeck_pilot_visuals@1x")
Framer.Device.contentScale = 1

slider = new PageComponent
	width: 800, height: 480
slider.center()
slider.scrollVertical = false

Framer.Device.on Events.Rotate, ->
	print "rotate"

Events.wrap(window).addEventListener "deviceorientation", (event) ->
	slider.center()

slides = [cd.rts,cd.facts,cd.store]

cd.products.states.add
	hide:
		scale: 0.8
		opacity: 0
	show:
		scale: 1
		opacity: 1
cd.products.states.animationOptions =
	curve: "spring(700,30,10)"
cd.products.originX = 0
cd.products.originY = 0.5
cd.products.states.switchInstant("hide")


for i,slide of slides
	slider.addPage(slide)
	slide.clip = true
	
cd.store_img0.minX = 0
cd.store_img0.minY = 0
cd.store_img1.minX = 0
cd.store_img1.minY = 0

panAnimation = (layer) ->
	down = new Animation
		layer: layer
		properties:
			minX: 100
			minY: 100
			scale: 0.8
		time: 15
		curve: "ease-in-out"
	up = down.reverse()
	down.start()
	down.onAnimationEnd ->
		up.start()
	up.onAnimationEnd ->
		down.start()

randProduct = Utils.randomChoice([cd.product0,cd.product1])
randProduct.bringToFront()
Utils.delay 0.2, ->
	cd.products.states.next("show")

slider.onChange "currentPage", ->
	randStore = Utils.randomChoice([this.currentPage.subLayers[0], this.currentPage.subLayers[1]])
	if this.currentPage.name == "store"
		randStore.bringToFront()
		panAnimation(randStore.subLayers[0])
	else
		
		cd.store_img0.minX = 0
		cd.store_img0.minY = 0
		cd.store_img1.minX = 0
		cd.store_img1.minY = 0
	if this.currentPage.name == "rts"
		randProduct = Utils.randomChoice([cd.product0,cd.product1])
		randProduct.bringToFront()
		Utils.delay 0.2, ->
			cd.products.states.next("show")
			
	if this.previousPage.name == "rts"
		Utils.delay 0.2, ->
			cd.products.states.switchInstant("hide")
	