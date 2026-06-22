class_name LadyLuck

var _ui: LadyLuckUI
var _grid: Grid


func set_ui(ui: LadyLuckUI) -> void:
	_ui = ui
	_ui.hold_item(null)


func set_grid(grid: Grid) -> void:
	_grid = grid


func clear_held() -> void:
	_ui.hold_item(null)


func cause_chaos(row: int, item: ItemResource) -> void:
	
	if !is_instance_valid(_ui):
		return
	
	_ui.hold_item(item)
	
	var row_cells = _grid.get_row(row)
	row_cells.shuffle()
	
	for cell in row_cells:
		
		if item.is_legal_play(cell):
			
			#print_debug("Playing %s to row %d" % [item.get_script().get_global_name(), row])
			
			_ui.play_item(cell)
			
			if item.get_script().get_global_name() == "BombResource": 
				Game.change_lady_luck_expression = "ohh"
			
			if item.get_script().get_global_name() == "TileResource": 
				Game.change_lady_luck_expression = "kiss"
			
			await _ui.finished
			
			if !is_instance_valid(_ui):
				return
			
			item.play(cell)
			break
			
	#print_debug("Cannot play %s in row %d" % [item.get_script().get_global_name(), row])
	Game.change_lady_luck_expression = "wait"
