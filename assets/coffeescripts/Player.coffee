class Player

	init: (playerNumber) ->

		self = this

		this.playerNumber = playerNumber

		this.color = 'rgb(240, 240, 240)'
		this.direction = false
		this.score = 0

		this.height = baseSize * 8
		this.width = baseSize

		this.position =
			x: if this.playerNumber == 1 then 20 else canvas.width - 20 - this.width
			y: (canvas.height / 2) - (this.height / 2)

		this.animateTo = this.position

		this.newPositionY = 0.5;
		this.maxPositionY = canvas.height - this.height

		this.velocity = 30

		@

	draw: ->

		context.fillStyle = this.color
		context.fillRect(this.position.x, this.position.y, this.width, this.height)

		@

	update: ->

		if this.player == 1
			console.log(this.newPositionY);

		this.position.y = this.maxPositionY * this.newPositionY

		@
