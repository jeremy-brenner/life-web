# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class LifeBoard
  constructor: () ->
    @board_state = []
    @board = $('#lifeboard')
    @loadState("")
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
    @add t.data('x'), t.data('y')
    Life.controls.setState @state()
    Life.api.reset()
  
  cellClass: (status) ->
    if status then @aliveClass else @deadClass

  state: (state=false) ->
    if state
      @loadState(state)
  
    ( "#{cell.x},#{cell.y}" for cell in @board_state ).join(':')
    #state_array.join(':')

  empty: ->
    !@state()

  cellStatus: (i,el) ->
    if $(el).data('status') then $(el).data() else undefined

  add: ( x, y ) ->
    @board_state.push
      x: x 
      y: y    
    $("i[data-x=#{x}][data-y=#{y}]").removeClass( @deadClass ).addClass( @aliveClass ).data('status', true)

  remove: ( x, y ) ->
    @board_state = @board_state.filter ( cell ) -> cell.x != x or cell.y != y 
    $("i[data-x=#{x}][data-y=#{y}]").removeClass( @aliveClass ).addClass( @deadClass ).data('status', false)

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