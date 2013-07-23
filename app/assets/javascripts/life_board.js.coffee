# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class LifeBoard
  constructor: () ->
    @board = $('#lifeboard')
    @board_state = []
    @board_cells = []
    @initCells()
    @loadState("")
    @bindCells()

  bindCells: ->
    @board.find('.cell').on 'click', @clickCell

  initCells: ->
    @board.find('.cell').each @initCell

  initCell: (i,cell) =>
    $cell = $(cell)
    @board_cells[$cell.data('x')] ?= []
    @board_cells[$cell.data('x')][$cell.data('y')] = $cell

  clickCell: (e) =>
    $t = $(e.target)
    new_status = not $t.data 'status' 
    if new_status
      @add $t.data('x'), $t.data('y')
    else
      @remove $t.data('x'), $t.data('y')
    Life.api.reset()  

  state: (state=false) ->
    if state
      @loadState(state)
  
    ( "#{cell.x},#{cell.y}" for cell in @board_state ).join(':')

  empty: ->
    !@state()

  cellStatus: (i,el) ->
    if $(el).data('status') then $(el).data() else undefined

  add: ( x, y ) ->
    @board_state.push
      x: x
      y: y
    @board_cells[x]?[y]?.addClass( 'alive' ).data('status', true)
    Life.controls.setState @state()

  remove: ( x, y ) ->
    @board_state = @board_state.filter ( cell ) -> parseInt(cell.x,10) != parseInt(x,10) or parseInt(cell.y,10) != parseInt(y,10)
    @board_cells[x]?[y]?.removeClass( 'alive' ).data('status', false)
    Life.controls.setState @state()

  reset: ->
    if @board_state
      @remove( cell.x, cell.y ) for cell in @board_state
      
  loadState: (state='') ->
    @reset()
    if state.length > 0
      coords = state.split ':'
      @add coord.split(',')[0], coord.split(',')[1] for coord in coords
      $('#state').val state
    else 
      Life.controls?.clickPause()
  
window.Life ||= {}
window.Life.LifeBoard = LifeBoard

jQuery ->
  window.Life.board = new Life.LifeBoard()