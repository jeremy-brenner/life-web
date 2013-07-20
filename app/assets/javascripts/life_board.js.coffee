# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class LifeBoard
  constructor: () ->
    @board = $('#lifeboard')
    @bindCells()

  aliveClass: 'icon-circle'
  deadClass: 'icon-circle-blank'

  bindCells: ->
    @board.find('i').on 'click', @clickCell

  clickCell: (e) =>
    t = $(e.target)
    new_status = not t.data 'status' 
    t.data('status', new_status )
    t.removeClass( @cellClass(!new_status) ).addClass( @cellClass(new_status) )
    Life.controls.setState @state()
    Life.api.reset()
  
  cellClass: (status) ->
    if status then @aliveClass else @deadClass

  state: (state=false) ->
    if state
      @loadState(state)

    state_array = []
    @board.find('i').each (i,el) =>
      if $(el).data('status')
        state_array.push "#{$(el).data('x')},#{$(el).data('y')}"
    state_array.join(':')

  empty: ->
    !@state()

  cellStatus: (i,el) ->
    if $(el).data('status') then $(el).data() else undefined

  add: (coords) ->
    [ x , y ] = coords.split ','
    $("i[data-x=#{x}][data-y=#{y}]").addClass( @aliveClass ).data('status', true)

  reset: ->
    @board.find('i').removeClass( @aliveClass ).addClass( @deadClass ).data('status', false)

  loadState: (state) ->
    @reset()
    if state.length > 0
      coords = state.split ':'
      @add coord for coord in coords
      $('#state').val state
    else 
      Life.controls.clickPause()
  
window.Life ||= {}
window.Life.LifeBoard = LifeBoard

jQuery ->
  window.Life.board = new Life.LifeBoard()