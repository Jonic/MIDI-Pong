delta       = 0
fpsOutput   = document.querySelector('.fps')
lastTime    = 0
pointsToWin = 15

animationLoop = (now) ->

	delta    = now - lastTime;
	fps      = Math.round(1000 / delta)
	lastTime = now;

	fpsOutput.innerHTML = fps

	canvas.width = canvas.width

	ball.draw()
	headsUp.draw()
	playerOne.draw()
	playerTwo.draw()

	ball.update()
	playerOne.update()
	playerTwo.update()

	window.requestAnimationFrame(animationLoop)

canvas  = document.createElement('canvas')
context = canvas.getContext('2d')

document.body.appendChild(canvas)

canvas.width  = document.body.clientWidth
canvas.height = document.body.clientHeight

baseSize  = Math.round(canvas.height * 0.015)
baseSize += 1 if baseSize % 2

ball      = new Ball()
headsUp   = new HeadsUp()
playerOne = new Player(1)
playerTwo = new Player(2)



controlCallback = (t, a, controlIndex, value) ->
	if controlIndex == 3  or controlIndex == 14
		paddle = playerOne

	if controlIndex == 11 or controlIndex == 22
		paddle = playerTwo

	if paddle
		value /= 128
		paddle.newPositionY = -(value - 1)

	return

document.getElementById('Jazz').MidiInOpen(0, controlCallback)

controller = new Option(' ', ' ', true, true)

animationLoopId = window.requestAnimationFrame(animationLoop)