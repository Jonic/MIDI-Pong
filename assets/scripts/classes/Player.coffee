class Player

  constructor: (playerNumber) ->

    @playerNumber = playerNumber

    @color = 'rgb(240, 240, 240)'
    @direction = false
    @score = 0

    @height = baseSize * 8
    @width = baseSize

    @position =
      x: if @playerNumber == 1 then 20 else canvas.width - 20 - @width
      y: (canvas.height / 2) - (@height / 2)

    @animateTo = @position

    @newPositionY = 0.5;
    @maxPositionY = canvas.height - @height

    @velocity = 30

    @

  draw: ->

    context.fillStyle = @color
    context.fillRect(@position.x, @position.y, @width, @height)

    @

  update: ->

    @position.y = @maxPositionY * @newPositionY

    @
