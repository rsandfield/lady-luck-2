class_name GridCell


signal grid_cell_pressed(cell: GridCell)


var _ui: GridCellUI
var _tile: TileResource

var _neighbors: Dictionary[TileResource.Direction, GridCell]


func set_ui(new_ui: GridCellUI) -> void:
	_ui = new_ui
	_ui.pressed.connect(_pressed)


func set_neighbor(direction: TileResource.Direction, neighbor: GridCell) -> void:
	_neighbors[direction] = neighbor


func get_neighbor(direction: TileResource.Direction) -> GridCell:
	return _neighbors.get(direction)


func get_neighbors() -> Array[GridCell]:
	return _neighbors.values()


func get_side(direction: TileResource.Direction) -> int:
	if !_tile:
		return -1
	return _tile.get_side(direction)


func is_occupied() -> bool:
	return _tile != null


func is_door() -> bool:
	return _tile && _tile.is_door


func is_legal_play(tile: TileResource) -> bool:
	# var matches = 0
	for direction in TileResource.Direction.values():
		if !_neighbors.has(direction):
			if tile.get_side(direction) > 0:
				return false
			continue

		var _neighbor = _neighbors[direction]
		if !_neighbor.is_legal_neighbor(TileResource.opposite(direction), tile):
			return false
		# if _neighbor.is_occupied() && !_neighbor.is_door():
		# 	matches += 1
	return true
	# return matches > 0
		

func is_legal_neighbor(direction: TileResource.Direction, tile: TileResource) -> bool:
	if !_tile:
		return true
	return _tile.is_legal_neighbor(direction, tile)


func set_tile(tile: TileResource) -> void:
	_tile = tile
	_ui.set_tile(tile)


func _pressed() -> void:
	grid_cell_pressed.emit(self)
