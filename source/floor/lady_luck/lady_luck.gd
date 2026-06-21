class_name LadyLuck

var _ui: LadyLuckUI
var _grid: Grid


func set_ui(ui: LadyLuckUI) -> void:
	_ui = ui
	_ui.hold_item(null)


func set_grid(grid: Grid) -> void:
	_grid = grid


func cause_chaos(row: int, item: ItemResource) -> void:
	if !is_instance_valid(_ui):
		return
	_ui.hold_item(item)
	var row_cells = _grid.get_row(row)
	row_cells.shuffle()
	var contents = []
	for cell in row_cells:
		contents.append(item.is_legal_play(cell))
		if item.is_legal_play(cell):
			print("Playing %s to row %d" % [item.get_script().get_global_name(), row])
			_ui.play_item(cell)
			await _ui.finished
			if !is_instance_valid(_ui):
				continue
			item.play(cell)
	print("Cannot play %s in row %d %s" % [item.get_script().get_global_name(), row, str(contents)])
