class_name LadyLuck


var _grid: Grid


func set_grid(grid: Grid) -> void:
	_grid = grid


func cause_chaos(row: int, item: ItemResource) -> void:
	var row_cells = _grid.get_row(row)
	row_cells.shuffle()
	for cell in row_cells:
		if item.is_legal_play(cell):
			item.play(cell)
			return
	print("Highly illegal")
	
