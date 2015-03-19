
class CanvasHelper

  constructor: ->

    @createCanvas()

    return this

  clear: ->

    #@element.width = @element.width
    @context.clearRect(0, 0, @element.width, @element.height)

    return this

  createCanvas: ->

    @element        = document.createElement('canvas')

    @element.height = document.body.clientHeight
    @element.width  = document.body.clientWidth

    document.body.appendChild(@element)

    @element.realHeight = @element.height
    @element.realWidth  = @element.width

    @context = @element.getContext('2d')

    @context.globalCompositeOperation = 'destination-atop'

    @scaleCanvas()

    return this

  scaleCanvas: ->

    backingStoreRatio = @context.webkitBackingStorePixelRatio || @context.backingStorePixelRatio || 1
    devicePixelRatio  = window.devicePixelRatio || 1

    if devicePixelRatio != backingStoreRatio
      ratio     = devicePixelRatio / backingStoreRatio
      oldWidth  = @element.width
      oldHeight = @element.height

      @element.width  = oldWidth  * ratio
      @element.height = oldHeight * ratio

      @element.style.width  = "#{oldWidth}px"
      @element.style.height = "#{oldHeight}px"

      @context.scale(ratio, ratio)

    return this
