# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class LifeBoard
  constructor: () ->
    @board = $('#lifeboard')
    @bindCells()
    @bindButtons()

  bindCells: ->
    @board.find('i').on 'click', @clickCell

  bindButtons: ->
    $('#playbutton').on 'click', @clickPlay

  clickCell: (e) =>
    t = $(e.target)
    new_state = not t.data 'state' 
    t.data('state', new_state )
    t.removeClass( @cellClass(!new_state) ).addClass( @cellClass(new_state) )
  
  clickPlay: (e) =>
    $('#state_form #life_state').val( @stateString() )
    $('#state_form').submit()

  cellClass: (state) ->
    if state then 'icon-circle' else 'icon-circle-blank'

  stateString: ->
    state_array = []
    @board.find('i').each (i,el) =>
      if $(el).data('state')
        state_array.push "#{$(el).data('x')},#{$(el).data('y')}"
    state_array.join(':')

  cellState: (i,el) ->
    if $(el).data('state') then $(el).data() else undefined

  cellGrep: (i,el) ->
    console.log el

window.LifeBoard = LifeBoard

jQuery ->
  window.life_board = new LifeBoard()