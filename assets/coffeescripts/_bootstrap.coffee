animationLoopId = null

fpsOutput = document.querySelector('.fps')

lastTime = 0

animationLoop = (time) ->

	fps = Math.round(1000 / (time - lastTime))
	lastTime = time;

	fpsOutput.innerHTML = fps

	canvas.width = canvas.width

	ball.draw()
	headsUp.draw()
	playerOne.draw()
	playerTwo.draw()

	if gamePaused
		window.setTimeout ->
			gamePaused = false

			ball.update()
			headsUp.update()
			playerOne.update()
			playerTwo.update()
		, 2000

	animationLoopId = window.requestAnimationFrame(animationLoop)

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

baseSize = Math.round(canvas.height * 0.015)



ball = new Ball()
ball.init()

playerOne = new Player()
playerOne.init(1)

playerTwo = new Player()
playerTwo.init(2)

headsUp = new HeadsUp()
headsUp.init()

gamePaused = true

animationLoop()
