class LifePlayer
  constructor: ->
    @playing = false
    @loop()

  play: ->
    @playing = true

  pause: ->
    @playing = false

  loop: ->
    setTimeout =>
      @tick() if @playing
      @loop()
    , 500

  tick: ->
    Life.api.nextState()

window.Life ||= {}
window.Life.LifePlayer = LifePlayer

jQuery ->
  window.Life.player = new Life.LifePlayer()