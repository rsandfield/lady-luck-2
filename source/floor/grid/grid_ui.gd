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

var _size: Vector2i
var _flags: Array[Flag]
var _spinning: bool
var _spin_row: int
var _spin_time: float
@export var _time_per_spin: float = 0.2


func _process(delta: float):
	if _spinning:
		_spin(delta)


func _spin(delta: float):
	_spin_time += delta
	if _spin_time >= _time_per_spin:
		_spin_time -= _time_per_spin
	else:
		return

	_flag_pulse(0.2)
	_spin_row += 1
	_spin_row %= _size.y


func _flag_pulse(time: float):
	var flag_index = _spin_row * 2
	_flags[flag_index].pulse(time)
	_flags[len(_flags) - flag_index - 1].pulse(time)


func set_grid(width: int, cells: Array[GridCell]) -> void:
	_flags = []
	for child in get_children():
		child.queue_free()

	@warning_ignore("INTEGER_DIVISION")
	_size = Vector2i(width, len(cells) / width)
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
			_add_flag(true, ROW_COLORS[rows - y])
			y += 1

		x += 1


func _add_flag(flip: bool, color: Color):
	var flag = FLAG_SCENE.instantiate()
	flag.flip = flip
	flag.color = color
	add_child(flag)
	_flags.append(flag)
	if color.a == 0:
		flag.disable()


func flag_spin(spin: bool):
	_spin_row = 0
	_spin_time = 0
	_spinning = spin


func flag_ladder(pulse_time: float, pulse_delay: float):
	for i in _size.y:
		if !is_inside_tree():
			return
		flag_pulse(i, pulse_time)
		await get_tree().create_timer(pulse_delay).timeout


func flag_pulse(row: int, time: float = 0.5):
	var flag_index = row * 2
	_flags[flag_index].pulse(time)
	_flags[flag_index + 1].pulse(time)
