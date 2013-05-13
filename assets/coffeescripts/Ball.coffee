class Ball

	init: ->

		self = this

		this.color = 'rgb(0, 102, 204)'

		this.size = 20
		this.half = this.size / 2

		this.position =
			x: (canvas.width  / 2)
			y: (canvas.height / 2)

		this.minVelocity = 10
		this.maxVelocity = 20

		this.velocity =
			x: 8
			y: 4

		this.directionX = 'right'
		this.directionY = 'down'

		@

	detectCollisionWithPaddle: ->

		if this.directionX == 'left'and (this.position.x - this.half) <= playerOne.position.x + playerOne.width
			ballY = this.position.y
			paddleY = playerOne.position.y

			if ballY >= paddleY and ballY <= (paddleY + playerOne.height)
				this.directionX = 'right'
				collision = true
		else if (this.position.x + this.half) >= playerTwo.position.x
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

		if this.directionY == 'up' and (this.position.y - this.half) <= 0
			this.directionY = 'down'
			collision = true
		else if (this.position.y + this.half) >= canvas.height
			this.directionY = 'up'
			collision = true

		if collision
		 	this.velocity.y = -this.velocity.y

		@

	draw: ->

		context.fillStyle = this.color

		context.beginPath()
		context.arc(this.position.x, this.position.y, this.half, 0, Math.PI * 2, true)
		context.closePath()
		context.fill()

		@

	update: ->

		this.detectCollisionWithPaddle()
		this.position.x += this.velocity.x

		this.detectCollisionWithCeilingOrFloor()
		this.position.y += this.velocity.y

		if this.position.x < 0 - this.half or this.position.x >= canvas.width + this.half
			console.log('GAME OVER')
			window.cancelAnimationFrame(animationLoopId)

		this.draw()

		@
