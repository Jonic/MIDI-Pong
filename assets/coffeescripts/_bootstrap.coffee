delta = 0
fpsOutput = document.querySelector('.fps')
lastTime = 0
pointsToWin = 15

animationLoop = (now) ->

	delta = now - lastTime;
	lastTime = now;

	fps = Math.round(1000 / delta)
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

	return

calcSpeed = (speed) ->
	return (speed * delta) * (60 / 1000)

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



canvas = document.createElement('canvas')
context = canvas.getContext('2d')

document.body.appendChild(canvas)

canvas.width = document.body.clientWidth
canvas.height = document.body.clientHeight

baseSize  = Math.round(canvas.height * 0.015)
baseSize += 1 if baseSize % 2



ball = new Ball()
ball.init()

playerOne = new Player()
playerOne.init(1)

playerTwo = new Player()
playerTwo.init(2)

headsUp = new HeadsUp()
headsUp.init()

animationLoopId = window.requestAnimationFrame(animationLoop)