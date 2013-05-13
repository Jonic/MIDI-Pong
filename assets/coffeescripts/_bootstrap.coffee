animationLoopId = null

animationLoop = ->

	animationLoopId = window.requestAnimationFrame(animationLoop)

	context.clearRect(0, 0, canvas.width, canvas.height)

	playerOne.update()
	playerTwo.update()

	ball.update()

	return

controlCallback = (t, a, controlIndex, value) ->
	value /= 128

	if controlIndex == 3  or controlIndex == 14
		paddle = playerOne

	if controlIndex == 11 or controlIndex == 22
		paddle = playerTwo

	paddle.newPositionY = -(value - 1)

	return

document.getElementById('Jazz').MidiInOpen(0, controlCallback)

controller = new Option(' ', ' ', true, true)



canvas = document.createElement('canvas')
context = canvas.getContext('2d')

document.body.appendChild(canvas)

canvas.width = document.body.clientWidth
canvas.height = document.body.clientHeight



ball = new Ball()
ball.init()

playerOne = new Paddle()
playerOne.init(1)

playerTwo = new Paddle()
playerTwo.init(2)

animationLoop()
