class HeadsUp

	init: ->

		this.netColor     = 'rgba(240, 240, 240, 0.25)'
		this.netWidth     = Math.round(baseSize / 2)

		if this.netWidth % 2
			this.netWidth += 1

		this.netLineWidth = Math.round(this.netWidth / 4)
		this.netX         = (canvas.width / 2) - (this.netWidth / 2)

		this.charPatterns = [
			[1, 1, 1, 1, 1, 1, 0] # 0
			[0, 1, 1, 0, 0, 0, 0]
			[1, 1, 0, 1, 1, 0, 1]
			[1, 1, 1, 1, 0, 0, 1]
			[0, 1, 1, 0, 0, 1, 1]
			[1, 0, 1, 1, 0, 1, 1]
			[1, 0, 1, 1, 1, 1, 1]
			[1, 1, 1, 0, 0, 0, 0]
			[1, 1, 1, 1, 1, 1, 1]
			[1, 1, 1, 0, 0, 1, 1] # 9
		]

		@

	draw: ->

		this.drawNet()
		this.drawScores()

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

	drawScores: ->

		score = '' + playerOne.score
		this.drawScoreCharacters(1, score)

		score = '' + playerTwo.score
		this.drawScoreCharacters(2, score)

		@

	drawScoreCharacters: (player, score) ->

		charCount = score.length
		charWidth = baseSize * 4
		unitLong  = baseSize * 3
		unitShort = baseSize

		startX = Math.round((canvas.width / 2))
		startY = Math.round(scoreStartY = baseSize * 2)

		if player == 1
			startX -= (baseSize * 2) + (charWidth * charCount) - this.netWidth
		else
			startX += (this.netWidth / 2) + (baseSize * 2)

		startX = Math.round(startX)

		posX = startX
		posY = startY

		console.log(posX, posY)

		for char in score.split('')
			char = parseInt(char, 10)
			pattern = this.charPatterns[char]

			# Three horizontal lines, top to bottom
			context.fillStyle = 'rgba(180, 180, 180, ' + pattern[0] + ')'
			context.fillRect(posX, posY, unitLong, unitShort)

			posY += baseSize * 2

			context.fillStyle = 'rgba(180, 180, 180, ' + pattern[6] + ')'
			context.fillRect(posX, posY, unitLong, unitShort)

			posY += baseSize * 2

			context.fillStyle = 'rgba(180, 180, 180, ' + pattern[3] + ')'
			context.fillRect(posX, posY, unitLong, unitShort)

			# Two lines on left side
			posX = startX
			posY = startY

			context.fillStyle = 'rgba(180, 180, 180, ' + pattern[5] + ')'
			context.fillRect(posX, posY, unitShort, unitLong)

			posY += baseSize * 2

			context.fillStyle = 'rgba(180, 180, 180, ' + pattern[4] + ')'
			context.fillRect(posX, posY, unitShort, unitLong)

			# Two lines on right side
			posX = startX + baseSize * 2
			posY = startY

			context.fillStyle = 'rgba(180, 180, 180, ' + pattern[1] + ')'
			context.fillRect(posX, posY, unitShort, unitLong)

			posY += baseSize * 2

			context.fillStyle = 'rgba(180, 180, 180, ' + pattern[2] + ')'
			context.fillRect(posX, posY, unitShort, unitLong)

			startX += charWidth

			posX = startX
			posY = startY

		@

	update: ->

		@