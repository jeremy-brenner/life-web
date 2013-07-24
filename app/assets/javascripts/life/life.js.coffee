class Life

  constructor: ( initial_state = "" ) ->
    @grid = new window.Life.Grid( @parse_state( initial_state ) )
 
  tick: ( iterations = 1 ) ->
    @grid.tick() for i in [1..iterations]
    @

  state: ->
    state = []
    state.push( coords.join(',') ) for coords in @grid.to_array()
    state.join ":"
  
  parse_state: ( state ) ->
    ( coords.split(',') for coords in state.split(':') )

window.Life ||= {}
window.Life.Life = Life