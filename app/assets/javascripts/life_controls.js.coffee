class LifeControls
  constructor: () ->
    @bindState()
    @bindButtons()
    @bindPresets()

  bindButtons: ->
    $('.icon-play').on 'click', @clickPlay
    $('.icon-pause').on 'click', @clickPause
    $('.icon-step-forward').on 'click', @clickForward
    $('.icon-refresh').on 'click', @clickRefresh

  bindPresets: ->
    $('#presets a').on 'click', @loadPreset

  bindState: ->
    $('#state').on 'input', @stateChange

  clickPlay: =>
    if Life.board.state()
      Life.player.play()
      @updateButtons()

  clickPause: =>
    Life.player.pause()
    @updateButtons()  
  
  clickRefresh: =>
    Life.board.reset()
    Life.api.reset()
    @clickPause()

  clickForward: =>
    Life.player.tick()

  updateButtons: ->
    $('.icon-play').toggleClass 'playing', Life.player.playing 

  loadPreset: (e) =>
    e.preventDefault()
    Life.controls.clickPause()
    Life.api.reset()
    s = $(e.target).data('state')
    Life.board.loadState s
    
  setState: (state_string) ->
    $('#state').val state_string

  stateChange: (e) =>
    Life.board.loadState $(e.target).val()


window.Life ||= {}
window.Life.LifeControls = LifeControls

jQuery ->
  window.Life.controls = new Life.LifeControls()