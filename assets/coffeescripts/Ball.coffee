class Ball

	init: ->

		self = this

		this.color = 'rgb(240, 240, 240)'

		this.size = baseSize
		this.half = this.size / 2

		this.position =
			x: (canvas.width  / 2)
			y: (canvas.height / 2)

		this.minVelocity = 10
		this.maxVelocity = 20

		this.velocity =
			x: Math.random() * 5 -10
			y: Math.random() * 5 -10

		this.directionX = if this.velocity.x < 0 then 'left' else 'right'
		this.directionY = if this.velocity.y < 0 then 'up'   else 'down'

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
		 	this.velocity.x = -this.velocity.x
		 	this.velocity.x *= 1.05
			#this.setNewVelocityX(ballX, paddleX)

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

		if this.position.x < 0 - this.half or this.position.x >= canvas.width + this.half
			console.log('GAME OVER')
			window.cancelAnimationFrame(animationLoopId)

		@

	update: ->

		if this.isStillInPlayingField()
			this.detectCollisionWithPaddle()
			this.position.x += this.velocity.x

			this.detectCollisionWithCeilingOrFloor()
			this.position.y += this.velocity.y

		@