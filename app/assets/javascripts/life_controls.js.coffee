class LifeControls
  constructor: () ->
    @bindState()
    @bindButtons()

  bindButtons: ->
    $('.icon-play').on 'click', @clickPlay
    $('.icon-pause').on 'click', @clickPause
    $('.icon-step-forward').on 'click', @clickForward
    $('.icon-refresh').on 'click', @clickRefresh

  bindState: ->
    $('#state').on 'input', @stateChange

  clickPlay: =>
    Life.player.play()
    @updateButtons()

  clickPause: =>
    Life.player.pause()
    @updateButtons()  
  
  clickRefresh: =>
    @clickPause()
    Life.board.reset()

  clickForward: =>
    Life.player.tick()

  updateButtons: ->
    $('.icon-play').toggleClass('playing', Life.player.playing ) 

  setState: (state_string) ->
    $('#state').val state_string

  stateChange: (e) =>
    Life.board.loadState $(e.target).val()


window.Life ||= {}
window.Life.LifeControls = LifeControls

jQuery ->
  window.Life.controls = new Life.LifeControls()