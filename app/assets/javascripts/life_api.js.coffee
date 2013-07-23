class LifeApi
  constructor: ->
    @state_list = []
    @min_queue_size = 100
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
    if @current_fetch == false and @state_list.length < @min_queue_size and not Life.board.empty()
      if @state_list.length == 0
        @fetch Life.board.state() 
      else
        @fetch @lastState() if @lastState() 

  ajaxSuccess: (object) =>
    if object.timestamp == @current_fetch
      @state_list = @state_list.concat object.state_list
      @current_fetch = false

  ajaxError: (e) =>
    console.log 'Life fetch error, retrying.'
    @current_fetch = false

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
