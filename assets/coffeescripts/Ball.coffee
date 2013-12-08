class Ball

	init: ->

		self = this

		this.color = 'rgb(240, 240, 240)'

		this.size = baseSize
		this.half = this.size / 2

		this.position =
			x: (canvas.width  / 2) - this.half
			y: (canvas.height / 2) - this.half

		velocityMin = -15
		velocityMax = 15

		this.velocity =
			x: (Math.random() * (velocityMax - velocityMin)) + velocityMin;
			y: (Math.random() * (velocityMax - velocityMin)) + velocityMin;

		this.correctVelocity()

		@

	correctVelocity: ->

		speedThreshold = 5

		if this.velocity.x < 0
			this.directionX = 'left'

			if this.velocity.x > -speedThreshold
				this.velocity.x = -speedThreshold
		else
			this.directionX = 'right'
			if this.velocity.x < speedThreshold
				this.velocity.x = speedThreshold

		if this.velocity.y < 0
			this.directionY = 'up'
			if this.velocity.y > -speedThreshold
				this.velocity.y = -speedThreshold
		else
			this.directionY = 'down'
			if this.velocity.y < speedThreshold
				this.velocity.y = speedThreshold

		@

	detectCollisionWithPaddle: ->

		if this.directionX == 'left' and this.position.x <= playerOne.position.x + playerOne.width
			ballY = this.position.y
			paddleY = playerOne.position.y

			if ballY >= paddleY and ballY <= (paddleY + playerOne.height)
				this.directionX = 'right'
				collision = true
		else if (this.position.x + this.size) >= playerTwo.position.x
			ballY = this.position.y
			paddleY = playerTwo.position.y

			if ballY >= paddleY and ballY <= (paddleY + playerTwo.height)
				this.directionX = 'left'
				collision = true

		if collision
			this.velocity.x = -(this.velocity.x * 1.05)

		@

	detectCollisionWithCeilingOrFloor: ->

		if this.directionY == 'up' and this.position.y <= 0
			this.directionY = 'down'
			collision = true
		else if this.position.y >= canvas.height - this.size
			this.directionY = 'up'
			collision = true

		if collision
		 	this.velocity.y = -this.velocity.y

		@

	draw: ->

		context.fillStyle = this.color
		context.fillRect(this.position.x, this.position.y, this.size, this.size)

		@

	isStillInPlayingField: ->

		insideLeft  = this.position.x > -(baseSize * 5)
		insideRight = this.position.x + this.size < canvas.width + (baseSize * 5)

		return insideLeft and insideRight

	update: ->

		if this.isStillInPlayingField()
			this.detectCollisionWithPaddle()
			this.position.x += calcSpeed(this.velocity.x)

			this.detectCollisionWithCeilingOrFloor()
			this.position.y += calcSpeed(this.velocity.y)
		else
			this.updateScoreStates()
			this.init()

		if playerOne.score == pointsToWin or playerTwo.score == pointsToWin
			console.log('GAME OVER')
			window.cancelAnimationFrame(animationLoopId)

		@

	updateScoreStates: ->

		outsideLeft = this.position.x < -(baseSize * 5)

		if outsideLeft
			playerTwo.score += 1
		else
			playerOne.score += 1

		@
