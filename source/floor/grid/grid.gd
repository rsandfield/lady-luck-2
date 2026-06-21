class_name Grid

signal grid_cell_pressed(cell: GridCell)

var _ui: GridUI
var _size: Vector2i
var _cells: Array[GridCell]
var _color_count: int
var _door: GridCell

func set_ui(new_ui: GridUI) -> void:
	_ui = new_ui


func set_grid_size(new_size: Vector2i, color_count: int = 2) -> void:
	_cells = []

	_size = new_size
	_color_count = color_count
	_rebuild_grid()
	_ui.set_grid(_size.x, _cells)

	_set_bottom_row()
	_set_door()


func _rebuild_grid() -> void:
	for i in _size.x * _size.y:
		var cell = GridCell.new()
		cell.grid_cell_pressed.connect(grid_cell_pressed.emit)
		cell.grid_cell_exploding.connect(_ui.show_explosion)
		_cells.append(cell)
		if i % _size.x > 0:
			var west_neighbor = _cells[i - 1]
			west_neighbor.set_neighbor(TileResource.Direction.EAST, cell)
			cell.set_neighbor(TileResource.Direction.WEST, west_neighbor)
		if i >= _size.x:
			var north_neighbor = _cells[i - _size.x]
			north_neighbor.set_neighbor(TileResource.Direction.SOUTH, cell)
			cell.set_neighbor(TileResource.Direction.NORTH, north_neighbor)


func _set_bottom_row():
	var bottom_start = _size.x * (_size.y - 1)
	var starters = range(_size.x)
	starters.shuffle()
	for i in _size.x:
		var ti = bottom_start + starters[i]
		var cell = _cells[ti]
		var sides: Array[int] = [0, 0, 0, 0]
		if i < _color_count:
			sides[0] = i + 1
		var tile = TileResource.new(sides)
		cell.set_tile(tile)
		cell.is_fixed = true


func _set_door():
	var it = _size.x + 1 + randi() % (_size.x - 2)
	var cell = _cells[it]
	var sides: Array[int] = [0, 0, 0, 0]
	for i in _color_count:
		sides[i] = i + 1
	sides.shuffle()
	var tile = TileResource.new(sides)
	tile.is_door = true
	cell.set_tile(tile)
	_door = cell


func activate_door() -> Signal:
	_ui.show_indicator(_door)
	return _door.grid_cell_pressed


func all_paths_finished() -> bool:
	for color in _color_count:
		if !_is_color_connected(color + 1):
			return false
	return true


func _is_color_connected(color: int) -> bool:
	var bottom_start = _size.x * (_size.y - 1)
	for i in _size.x:
		var cell = _cells[bottom_start + i]
		if cell.get_side(TileResource.Direction.NORTH) == color:
			var path = _depth_search(color, [], cell)
			return _door_visited(path)
	return false


func _depth_search(color: int, visited: Array[GridCell], cell: GridCell) -> Array[GridCell]:
	visited.append(cell)
	if cell.is_door():
		return visited

	for direction in TileResource.Direction.values():
		var neighbor = cell.get_neighbor(direction)
		if !neighbor || visited.has(neighbor):
			continue
		if (
			cell.get_side(direction) == color
			&& neighbor.get_side(TileResource.opposite(direction)) == color
		):
			visited = _depth_search(color, visited, neighbor)
	return visited


func _door_visited(visited: Array[GridCell]) -> bool:
	for cell in visited:
		if cell.is_door():
			return true
	return false


func get_row(row: int) -> Array[GridCell]:
	return _cells.slice(row * _size.x, row * (_size.x + 1))


func flag_spin(spin: bool):
	_ui.flag_spin(spin)


func flash_all_flags():
	for i in 3:
		if !is_instance_valid(_ui):
			return
		_ui.flag_ladder(0.2, 0.1)
		await Game.get_tree().create_timer(0.05 * _size.y).timeout


func count_bombable_tiles() -> int:
	var bomb = BombResource.new()
	var count = 0
	for cell in _cells:
		if bomb.is_legal_play(cell):
			count += 1
	return count


func pulse_row(row: int):
	for i in 3:
		if !is_instance_valid(_ui):
			return
		_ui.flag_pulse(row)
		await Game.get_tree().create_timer(0.5).timeout
