class Grid

  constructor: ( initial_state ) ->
    @build_grid initial_state
  
  tick: ->
    @find_neighbors()
    @rebuild_grid()
    @iteration+=1

  build_grid: ( state ) ->
    @iteration = 0
    @cells = {}
    @add_cell coords[0], coords[1] for coords in state 

  add_cell: ( x, y ) -> 
    c = new window.Life.Cell(x,y)
    @cells[c.key()] = c

  find_neighbors: ->
    keys = Object.keys(@cells)
    for a in [0...keys.length]
      for b in [a+1...keys.length] 
        keya = keys[a]
        keyb = keys[b]
        if @cells[keya].neighbor_of @cells[keyb]
          @cells[keya].add_neighbor()
          @cells[keyb].add_neighbor()

  rebuild_grid: ->
    new_grid = {}
    baby_cells = {}

    for key, cell of @cells 
      k = key
      #touch possible babies
      for baby in cell.neighbors() 
        baby_cells[ baby ] ?= 0
        baby_cells[ baby ] += 1

      # reset and copy cell to new grid if it lives
      if cell.fate()
        new_grid[cell.key()] = cell.reset()
      
    for baby_key in Object.keys(baby_cells)
      if baby_cells[baby_key] == 3
        [ x, y ] = baby_key.split(',')
        c = new window.Life.Cell( x, y )
        new_grid[c.key()] = c
    
    @cells = new_grid

  to_array: ->
    ( [ cell.x, cell.y ] for key, cell of @cells )
  
window.Life ||= {}
window.Life.Grid = Grid