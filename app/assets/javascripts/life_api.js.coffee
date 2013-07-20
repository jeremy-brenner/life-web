class LifeApi
  constructor: ->
    @state_list = []
    @bindForm()
    @loop()

  bindForm: ->
    $('#state_form').on 'ajax:success', @ajaxSuccess
    $('#state_form').on 'ajax:error', @ajaxError

  fetch: (state) =>
    @current_fetch = new Date().toISOString()
    $('#state_form #life_state').val state 
    $('#state_form #life_timestamp').val @current_fetch
    $('#state_form').submit()

  update: ->
    if @state_list.length < 20 and not Life.board.empty()
      if @state_list.length == 0
        @fetch Life.board.state() 
      else
        @fetch @lastState() if @lastState() 

  ajaxSuccess: (e, object) =>
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
