class LifeApi
  constructor: ->
    @state_list = []
    @loop()

  fetch: (state) =>
    @current_fetch = new Date().toISOString()
    $.ajax
      type: "POST"
      url: '/life.json'
      async: true
      data:
        "life[state]": state
        "life[timestamp]": @current_fetch
      success: @ajaxSuccess
      error: @ajaxError
      dataType: 'json'
    
  update: ->
    if @state_list.length < 40 and not Life.board.empty()
      if @state_list.length == 0
        @fetch Life.board.state() 
      else
        @fetch @lastState() if @lastState() 

  ajaxSuccess: (object) =>
    if object.timestamp == @current_fetch
      @state_list = @state_list.concat object.state_list

  ajaxError: (e) =>
    console.log 'error', e

  lastState: ->
    @state_list[@state_list.length - 1]

  nextState: ->
    if @state_list.length > 0
      Life.board.loadState @state_list.shift()
  
  reset: ->
    @current_fetch = false
    @state_list = []
  
  loop: ->
    setTimeout =>
      @update()
      @loop()
    , 500


window.Life ||= {}
window.Life.LifeApi = LifeApi

jQuery ->
  window.Life.api = new Life.LifeApi()
