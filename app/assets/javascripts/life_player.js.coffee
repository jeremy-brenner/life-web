class LifePlayer
  constructor: ->
    @playing = false
    @delay = 300
    @loop()

  play: ->
    @playing = true

  pause: ->
    @playing = false

  loop: ->
    setTimeout =>
      @tick() if @playing
      @loop()
    , @delay

  tick: ->
    Life.api.nextState()

window.Life ||= {}
window.Life.LifePlayer = LifePlayer

jQuery ->
  window.Life.player = new Life.LifePlayer()