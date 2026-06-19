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
	for cell in row_cells:
		if item.is_legal_play(cell):
			print("Playing %s" % item.get_script().get_global_name())
			_ui.play_item(cell)
			await _ui.finished
			if !is_instance_valid(_ui):
				return
			item.play(cell)
			return
	print("Highly illegal %d %s" % [row, item.get_script().get_global_name()])
