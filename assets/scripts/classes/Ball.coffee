class Ball

  constructor: ->

    @color = 'rgb(240, 240, 240)'

    @size = baseSize
    @half = @size / 2

    @velocityMin = -15
    @velocityMax = 15

    @reset()

    @

  reset: ->

    @position =
      x: (canvas.width  / 2) - @half
      y: (canvas.height / 2) - @half

    @velocity =
      x: (Math.random() * (@velocityMax - @velocityMin)) + @velocityMin
      y: (Math.random() * (@velocityMax - @velocityMin)) + @velocityMin

    @correctVelocity()

  correctVelocity: ->

    speedThreshold = 5

    if @velocity.x < 0
      @directionX = 'left'
      @velocity.x = -speedThreshold if @velocity.x > -speedThreshold
    else
      @directionX = 'right'
      @velocity.x = speedThreshold if @velocity.x < speedThreshold

    if @velocity.y < 0
      @directionY = 'up'
      @velocity.y = -speedThreshold if @velocity.y > -speedThreshold
    else
      @directionY = 'down'
      @velocity.y = speedThreshold if @velocity.y < speedThreshold

    @

  detectCollisionWithPaddle: ->

    if @directionX == 'left' and @position.x <= playerOne.position.x + playerOne.width
      ballY   = @position.y
      paddleY = playerOne.position.y

      if ballY >= paddleY and ballY <= (paddleY + playerOne.height)
        @directionX = 'right'
        collision   = true
    else if (@position.x + @size) >= playerTwo.position.x
      ballY   = @position.y
      paddleY = playerTwo.position.y

      if ballY >= paddleY and ballY <= (paddleY + playerTwo.height)
        @directionX = 'left'
        collision   = true

    @velocity.x = -(@velocity.x * 1.05) if collision

    @

  detectCollisionWithCeilingOrFloor: ->

    if @directionY == 'up' and @position.y <= 0
      @directionY = 'down'
      collision   = true
    else if @position.y >= canvas.height - @size
      @directionY = 'up'
      collision   = true

    @velocity.y = -@velocity.y if collision

    @

  draw: ->

    context.fillStyle = @color
    context.fillRect(@position.x, @position.y, @size, @size)

    @

  isStillInPlayingField: ->

    insideLeft  = @position.x > -(baseSize * 5)
    insideRight = @position.x + @size < canvas.width + (baseSize * 5)

    return insideLeft && insideRight

  update: ->

    if @isStillInPlayingField()
      @detectCollisionWithPaddle()
      @position.x += calcSpeed(@velocity.x)

      @detectCollisionWithCeilingOrFloor()
      @position.y += calcSpeed(@velocity.y)
    else
      @updateScoreStates()
      @reset()

    playerOneWins = playerOne.score == pointsToWin
    playerTwoWins = playerTwo.score == pointsToWin

    if playerOneWins || playerTwoWins
      winner = if playerOneWins then 'One' else 'Two'
      alert "Player #{winner} Wins!"
      window.cancelAnimationFrame()

    @

  updateScoreStates: ->

    outsideLeft = @position.x < -(baseSize * 5)

    if outsideLeft
      playerTwo.score += 1
    else
      playerOne.score += 1

    @
