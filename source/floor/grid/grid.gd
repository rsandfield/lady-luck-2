class_name Grid

signal grid_cell_pressed(cell: GridCell)


var _ui: GridUI
var _cells: Array[GridCell]

func set_ui(new_ui: GridUI) -> void:
	_ui = new_ui


func set_grid_size(new_size: Vector2i) -> void:
	_cells = []
	
	var width = new_size.x
	var height = new_size.y
	_rebuild_grid(width, height)
	_ui.set_grid(width, _cells)

	_set_bottom_row(width, height)
	_set_door(width)


func _rebuild_grid(width: int, height: int) -> void:
	for i in width * height:
		var cell = GridCell.new()
		cell.grid_cell_pressed.connect(grid_cell_pressed.emit)
		_cells.append(cell)
		if i % width > 0:
			var west_neighbor = _cells[i - 1]
			west_neighbor.set_neighbor(TileResource.Direction.EAST, cell)
			cell.set_neighbor(TileResource.Direction.WEST, west_neighbor)
		if i > width:
			var north_neighbor = _cells[i - width]
			north_neighbor.set_neighbor(TileResource.Direction.SOUTH, cell)
			cell.set_neighbor(TileResource.Direction.NORTH, north_neighbor)


func _set_bottom_row(width: int, height: int):
	var starters = range(width)
	var bottom_start = width * (height - 1)
	for i in width:
		var ti = bottom_start + i
		var cell = _cells[ti]
		var sides: Array[int] = [0, 0, 0, 0]
		if i == starters[0]:
			sides[0] = 1
		var tile = TileResource.new(sides)
		cell.set_tile(tile)


func _set_door(width):
	var i = width +  randi() % width
	var cell = _cells[i]
	var sides: Array[int] = [0, 0, 0, 1]
	sides.shuffle()
	var tile = TileResource.new(sides)
	tile.is_door = true
	cell.set_tile(tile)
	
