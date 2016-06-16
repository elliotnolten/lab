# Variables
cards = []
cardCount = 32
index = 1
maxIndex = cardCount - 5
delay = 2

bg = new BackgroundLayer backgroundColor: "#183051"

reviewsHolder = new Layer
	width: 400, height: 120 * 4, clip: true, backgroundColor: null
reviewsHolder.center()

reviews = new PageComponent
	parent: reviewsHolder
	width: 400, height: 120
	backgroundColor: null, clip: false
reviews.scrollHorizontal = false

reviews.centerX()

# Cards
for i in [0...cardCount]
	card = new Layer
		parent: reviews.content
		width: 400, height: 100, y: (i - 1) * (100+20)
	cardShadow = new Layer
		parent: card
		width: card.width * 0.9, height: card.height * 0.9
		y: 20
		backgroundColor: "rgba(0,0,0,0.5)"
		blur: 10
	cardContainer = new Layer
		parent: card
		width: card.width, height: card.height
		backgroundColor: Utils.randomColor 1
	cardShadow.centerX()
	card.scale = 0.9
	cards.push(card)

# Scale first cards
for i,card of cards
	card.scale = 1 unless i > 4

# Animation
moveCards = () ->

	reviews.snapToPage(
		cards[index]
		true
		animationOptions = curve: "spring(50,10,0)"
	)
	
	previousPage = cards[index - 1]
	nextPage = cards[index + 3]
	
	previousPage.animate
		properties:
			opacity: 0
			scale: 0.9
			y: previousPage.y + 120
		curve: "spring(50,10,0)"
	
	nextPage.animate
		properties:
			scale: 1
		curve: "spring(50,10,0)"
	
	index++

Utils.interval delay, ->
	moveCards() unless index > maxIndex

