class_name GridCell

signal grid_cell_pressed(cell: GridCell)

var _ui: GridCellUI
var _tile: ItemResource
var is_fixed: bool = false

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


func position() -> Vector2:
	return _ui.global_position


func is_occupied() -> bool:
	return _tile != null


func is_door() -> bool:
	return _tile && _tile.is_door


func is_legal_play(item: ItemResource) -> bool:
	return item.is_legal_play(self)


func is_legal_neighbor(direction: TileResource.Direction, tile: TileResource) -> bool:
	if !_tile:
		return true
	return _tile.is_legal_neighbor(direction, tile)


func set_tile(tile: TileResource) -> void:
	_tile = tile
	_ui.set_tile(tile)


func clear() -> void:
	_ui.set_tile(null)
	_tile = null


func _pressed() -> void:
	grid_cell_pressed.emit(self)
