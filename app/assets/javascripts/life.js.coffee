# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class LifeBoard
  constructor: () ->
    @playing = false
    @board = $('#lifeboard')
    @bindCells()
    @bindButtons()
    @bindForm()

  aliveClass: 'icon-circle'

  deadClass: 'icon-circle-blank'

  bindForm: ->
    $('#state_form').on 'ajax:success', @ajaxSuccess
    $('#state_form').on 'ajax:error', @ajaxError

  bindCells: ->
    @board.find('i').on 'click', @clickCell

  bindButtons: ->
    $('#playbutton').on 'click', @clickPlay
    $('#pausebutton').on 'click', @clickPause
    $('#stepbutton').on 'click', @tick

  clickCell: (e) =>
    t = $(e.target)
    new_status = not t.data 'status' 
    t.data('status', new_status )
    t.removeClass( @cellClass(!new_status) ).addClass( @cellClass(new_status) )
  
  clickPlay: (e) =>
    @playing = true
    @updateButtons()
    @tick()

  clickPause: =>
    @playing = false
    @updateButtons()  
  
  updateButtons: ->
    $('#playbutton').parent().toggleClass('hidden', @playing)
    $('#pausebutton').parent().toggleClass('hidden', !@playing)  

  tick: =>
    $('#state_form #life_state').val( @stateString() )
    $('#state_form').submit()

  cellClass: (status) ->
    if status then @aliveClass else @deadClass

  stateString: ->
    state_array = []
    @board.find('i').each (i,el) =>
      if $(el).data('status')
        state_array.push "#{$(el).data('x')},#{$(el).data('y')}"
    state_array.join(':')

  cellStatus: (i,el) ->
    if $(el).data('status') then $(el).data() else undefined

  add: (coords) ->
    [ x , y ] = coords.split ','
    $("i[data-x=#{x}][data-y=#{y}]").addClass( @aliveClass ).data('status', true)

  resetBoard: ->
    @board.find('i').removeClass( @aliveClass ).addClass( @deadClass ).data('status', false)

  loadState: (state) ->
    coords = state.split ':'
    @add coord for coord in coords
  
  ajaxSuccess: (e, object) =>
    @resetBoard()
    @loadState object.state
    setTimeout =>
      @tick() if @playing
    , 500

  ajaxError: (e) =>
    console.log 'error', e

window.LifeBoard = LifeBoard

jQuery ->
  window.life_board = new LifeBoard()