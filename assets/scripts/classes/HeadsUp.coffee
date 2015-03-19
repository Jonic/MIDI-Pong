class HeadsUp

  constructor: ->

    @netColor  = 'rgba(240, 240, 240, 0.25)'
    @netWidth  = Math.round(baseSize / 2)
    @netWidth += 1 if @netWidth % 2

    @netLineWidth  = Math.round(@netWidth / 4)
    @netLineWidth += 1 if @netLineWidth % 2

    @netX = Math.round((canvas.width / 2) - (@netWidth / 2))

    @charPatterns = [
      [1, 1, 1, 1, 1, 1, 0] # 0
      [0, 1, 1, 0, 0, 0, 0] # 1
      [1, 1, 0, 1, 1, 0, 1] # 2
      [1, 1, 1, 1, 0, 0, 1] # 3
      [0, 1, 1, 0, 0, 1, 1] # 4
      [1, 0, 1, 1, 0, 1, 1] # 5
      [1, 0, 1, 1, 1, 1, 1] # 6
      [1, 1, 1, 0, 0, 0, 0] # 7
      [1, 1, 1, 1, 1, 1, 1] # 8
      [1, 1, 1, 0, 0, 1, 1] # 9
    ]

    @

  draw: ->

    @drawNet()
    @drawScores()

    @

  drawNet: ->

    context.fillStyle = @netColor
    context.strokeStyle = @netColor

    netY = 0

    context.lineWidth = @netLineWidth
    context.beginPath()

    while netY < canvas.height
      context.moveTo(@netX, netY + @netLineWidth)
      context.lineTo(@netX + @netWidth, netY + @netLineWidth)

      netY += @netLineWidth * 2

    context.closePath()
    context.fill()
    context.stroke()

    @

  drawScores: ->

    score = '' + playerOne.score
    @drawScoreCharacters(1, score)

    score = '' + playerTwo.score
    @drawScoreCharacters(2, score)

    @

  drawScoreCharacters: (player, score) ->

    charCount = score.length
    charWidth = baseSize * 4
    unitLong  = baseSize * 3
    unitShort = baseSize

    startX = Math.round((canvas.width / 2))
    startY = Math.round(scoreStartY = baseSize * 2)

    if player == 1
      startX -= (baseSize * 2) + (charWidth * charCount) - @netWidth
    else
      startX += (@netWidth / 2) + (baseSize * 2)

    startX = Math.round(startX)

    posX = startX
    posY = startY

    for char in score.split('')
      char    = parseInt(char, 10)
      pattern = @charPatterns[char]

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