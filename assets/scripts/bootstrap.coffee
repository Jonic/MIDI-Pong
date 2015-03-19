delta       = 0
fpsOutput   = document.querySelector('.fps')
lastTime    = 0
pointsToWin = 15

canvasHelper = new CanvasHelper()

canvas  = canvasHelper.element;
context = canvasHelper.context;

baseSize  = Math.round(canvas.height * 0.015)
baseSize += 1 if baseSize % 2

ball      = new Ball()
playerOne = new Player(1)
playerTwo = new Player(2)
headsUp   = new HeadsUp()

navigator.requestMIDIAccess().then (midiAccess) ->
  input = midiAccess.inputs.values().next()

  input.value.onmidimessage = (event) ->
    console.log event.data

    control = event.data[1]

    if control?
      value   = event.data[2]

      console.log(control, value);

      paddle = playerOne if control == 3  || control == 14
      paddle = playerTwo if control == 11 || control == 22

      if paddle
        value /= 128
        paddle.newPositionY = -(value - 1)

animationLoop = (now) =>

  delta    = now - lastTime
  fps      = Math.round(1000 / delta)
  lastTime = now

  fpsOutput.innerHTML = fps

  #context.clearRect(0, 0, canvas.width, canvas.height)
  canvas.width = canvas.width

  ball.draw()
  playerOne.draw()
  playerTwo.draw()
  headsUp.draw()

  ball.update()
  playerOne.update()
  playerTwo.update()

  window.requestAnimationFrame(animationLoop)

animationLoop()
