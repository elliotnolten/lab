class exports.Look extends ScrollComponent
	position: 0
	items: {}
	addNewItem: (item) ->
		if @items[item.name]?
			return
		@items[item.name] = item
		itemLayer = new Layer
			html: item.name
			parent: @content
			x: @position
			backgroundColor: item.color
		@position += itemLayer.width + 10
		@content.width += itemLayer.width + 10

class exports.Item
	color: 'red'
	name: null
	constructor: (name,color) ->
		@name = name
		@color = color

class exports.Button extends Layer
	constructor: (options) ->
		super options
		@look = options.look
		@currentNewPosition = @maxX + 10
		@item = new exports.Item(options.name,Utils.randomColor())

		@onClick ->
			@createLayerNextToIt()

	createLayerNextToIt: () ->
		@look.addNewItem(@item)
