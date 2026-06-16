class_name GridUI
extends GridContainer

const GRID_CELL_UI_SCENE = preload("./grid_cell_ui.tscn")

func set_grid(width: int, cells: Array[GridCell]) -> void:
	for child in get_children():
		child.queue_free()

	columns = width

	for cell in cells:
		var cell_ui = GRID_CELL_UI_SCENE.instantiate()
		add_child(cell_ui)
		cell.set_ui(cell_ui)
