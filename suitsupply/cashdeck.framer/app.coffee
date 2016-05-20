# Import file "cashdeck_pilot_visuals"
cd = Framer.Importer.load("imported/cashdeck_pilot_visuals@1x")
Framer.Device.contentScale = 1

slider = new PageComponent
	width: 800, height: 480
slider.center()
slider.scrollVertical = false

Events.wrap(window).addEventListener "resize", (event) ->
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

panAnimation = (layer) ->
	layer.animate
		properties: 
			minX: 800
			minY: 480
		time: 90

randProduct = Utils.randomChoice([cd.product0,cd.product1])
randProduct.bringToFront()
Utils.delay 0.2, ->
	cd.products.states.next("show")

slider.onChange "currentPage", ->
	if this.currentPage.name == "store"
		randStore = Utils.randomChoice([this.currentPage.subLayers[0], this.currentPage.subLayers[1]])
		randStore.bringToFront()
		panAnimation(randStore.subLayers[0])
	if this.currentPage.name == "rts"
		randProduct = Utils.randomChoice([cd.product0,cd.product1])
		randProduct.bringToFront()
		Utils.delay 0.2, ->
			cd.products.states.next("show")
	if this.previousPage.name == "rts"
		Utils.delay 0.2, ->
			cd.products.states.switchInstant("hide")
	