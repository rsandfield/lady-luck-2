class_name GridCell


signal grid_cell_pressed(cell: GridCell)


var _ui: GridCellUI
var _tile: TileResource


func set_ui(new_ui: GridCellUI) -> void:
	_ui = new_ui
	_ui.pressed.connect(_pressed)


func is_occupied() -> bool:
	return false


func set_tile(tile: TileResource) -> void:
	_tile = tile
	_ui.set_tile(tile)


func _pressed() -> void:
	grid_cell_pressed.emit(self)
