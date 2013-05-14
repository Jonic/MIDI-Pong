class HeadsUp

	init: ->

		this.netColor     = 'rgba(240, 240, 240, 0.25)'
		this.netWidth     = Math.round(baseSize / 2)
		this.netLineWidth = Math.round(this.netWidth / 3)
		this.netX         = (canvas.width / 2) - (this.netWidth / 2)

		@

	draw: ->

		this.drawNet()
		this.drawScore()

		@

	drawNet: ->

		context.fillStyle = this.netColor
		context.strokeStyle = this.netColor

		netY = 0

		context.lineWidth = this.netLineWidth
		context.beginPath()

		while netY < canvas.height
			context.moveTo(this.netX, netY + this.netLineWidth)
			context.lineTo(this.netX + this.netWidth, netY + this.netLineWidth)

			netY += this.netLineWidth * 2

		context.closePath()
		context.fill()
		context.stroke()

	drawScore: ->

		@

	update: ->

		@