class Cell

  constructor: ( x,y ) ->
    [ @x, @y ] = [ parseInt(x), parseInt(y) ]
    @reset()
  
  reset: ->
    @neighbor_count = 0
    @

  fate: ->
    @neighbor_count == 2 || @neighbor_count == 3

  key: ->
    @my_key ?= @coord_key( @x, @y )

  coord_key: (x,y) ->
    "#{x},#{y}"

  neighbor_of: ( cell ) ->
    ( @neighbors().filter (k) -> k == cell.key() ).length > 0

  add_neighbor: ->
    @neighbor_count+=1

  neighbors: ->
    # since cells don't move the @neighbors array will never change
    @neighbor_cells ?= ( @coord_key coords[0], coords[1] for coords in @neighbor_coords() )


  neighbor_coords: ->
    [
      [ @x-1, @y-1 ], [ @x-1, @y ], [ @x-1, @y+1 ],
      [ @x,   @y-1 ],               [ @x,   @y+1 ],
      [ @x+1, @y-1 ], [ @x+1, @y ], [ @x+1, @y+1 ]
    ]

window.Life ||= {}
window.Life.Cell = Cell

