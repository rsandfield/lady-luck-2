class_name GridUI
extends GridContainer

const GRID_CELL_UI_SCENE = preload("./grid_cell_ui.tscn")
const FLAG_SCENE = preload("./flag.tscn")

const ROW_COLORS: Array[Color] = [
	Color(0, 0, 0, 0),
	Color.RED,
	Color.ORANGE,
	Color.YELLOW,
	Color.GREEN,
	Color.BLUE,
	Color.INDIGO,
	Color.VIOLET,
]

func set_grid(width: int, cells: Array[GridCell]) -> void:
	for child in get_children():
		child.queue_free()

	columns = width + 2
	@warning_ignore("INTEGER_DIVISION")
	var rows = len(cells) / width

	var x = 0
	var y = 1
	for cell in cells:
		if x % width == 0:
			_add_flag(false, ROW_COLORS[rows - y])
		
		var cell_ui = GRID_CELL_UI_SCENE.instantiate()
		add_child(cell_ui)
		cell.set_ui(cell_ui)
		
		if x % width == width - 1:
			print(y, " ", rows)
			_add_flag(true, ROW_COLORS[rows - y])
			y += 1
			
		x += 1

func _add_flag(flip: bool, color: Color):
	var flag = FLAG_SCENE.instantiate()
	flag.flip_h = flip
	flag.modulate = color
	add_child(flag)
