# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class LifeBoard
  constructor: (id) ->
    @board = $(id)
    @bindCells()

  bindCells: ->
    @board.find('i').on 'click', @clickCell

  clickCell: (e) ->
    console.log 'clicked', e


window.LifeBoard = LifeBoard

jQuery ->
  window.life_board = new LifeBoard('#lifeboard')