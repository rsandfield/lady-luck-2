class_name Grid

signal grid_cell_pressed(cell: GridCell)


var _ui: GridUI
var _cells: Array[GridCell]

func set_ui(new_ui: GridUI) -> void:
	_ui = new_ui


func set_grid_size(new_size: Vector2i) -> void:
	_cells = []
	for i in new_size.x * new_size.y:
		var cell = GridCell.new()
		cell.grid_cell_pressed.connect(grid_cell_pressed.emit)
		_cells.append(cell)
	_ui.set_grid(new_size.x, _cells)
