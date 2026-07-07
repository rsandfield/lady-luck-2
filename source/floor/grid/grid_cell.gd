class_name GridCell
extends ItemSlot

signal grid_cell_exploding(cell: GridCell)
signal grid_cell_pressed(cell: GridCell)

var _ui: GridCellUI
var is_fixed: bool = false

var _neighbors: Dictionary[TileResource.Direction, GridCell]


func set_ui(new_ui: GridCellUI) -> void:
	_ui = new_ui
	_ui.pressed.connect(_pressed)
	_ui.hovered.connect(_on_hovered)


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
	return _ui.global_position + _ui.size / 2


func center_position() -> Vector2:
	return _ui.global_position + _ui.size / 2


func size() -> Vector2:
	return _ui.size


func is_door() -> bool:
	return _tile && _tile.is_door


func is_legal_neighbor(direction: TileResource.Direction, tile: TileResource) -> bool:
	if !_tile:
		return true
	return _tile.is_legal_neighbor(direction, tile)


func set_tile(tile: ItemResource) -> void:
	_tile = tile
	_ui.set_tile(tile)


func explode() -> void:
	grid_cell_exploding.emit(self)
	clear()


func clear() -> void:
	_ui.set_tile(null)
	super.clear()


func press() -> void:
	slot_pressed.emit(self)
	grid_cell_pressed.emit(self)


func _pressed() -> void:
	press()


func _on_hovered(is_hovered: bool) -> void:
	if is_hovered:
		Game.grid_tile_hovered = self
	elif Game.grid_tile_hovered == self:
		Game.grid_tile_hovered = null
