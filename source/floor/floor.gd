class_name Floor
extends PanelContainer

@export var _config: FloorConfig = FloorConfig.new()

@onready var _turn_counter: PointsContainer = %TurnContainer

var _slot_machine: SlotMachine
var _grid: Grid
var _spinner: Spinner
var _lady: LadyLuck


signal moving_tile(is_clicked: bool)
signal slot_machine_sound


func _ready():
	reset()


func reset(config: FloorConfig = null):
	if config:
		_config = config

	_slot_machine = SlotMachine.new()
	_slot_machine.set_ui(%SlotMachine)
	_slot_machine.set_wheel_count(_config.wheel_count)
	_slot_machine.finished.connect(_on_spin_finished)

	_grid = Grid.new()
	_grid.set_ui(%Grid)
	_grid.grid_cell_pressed.connect(_on_grid_cell_pressed)
	_grid.set_grid_size(_config.grid_size)

	_spinner = Spinner.new()
	_spinner.set_ui(%Spinner)
	_spinner.set_row_count(_config.grid_size.y)
	_spinner.set_item_count(6)
	_slot_machine.lever_pulled.connect(_on_lever_pulled)

	_lady = LadyLuck.new()
	_lady.set_ui(%LadyLuck)
	_lady.set_grid(_grid)
	_spinner.result.connect(_on_lady_play)


func _on_grid_cell_pressed(slot: GridCell) -> void:
	var item = _slot_machine.get_selected_item()
	if !item:
		return
	if !slot.is_legal_play(item):
		return

	item.play(slot)
	_slot_machine.consume_selected()

	if _grid.all_paths_finished():
		print("Ya did it")


func _on_lever_pulled():
	_grid.flag_spin(true)
	_spinner.spin()
	_turn_counter.add_value(1)


func _on_spin_finished():
	_grid.flag_spin(false)
	_grid.flash_all_flags()


func _on_lady_play(row: int, item: ItemResource):
	_lady.cause_chaos(row, item)
	_grid.pulse_row(row)


func _on_slot_machine_moving_tile(is_moving: bool) -> void:
	#print_debug( "_on_slot_machine_moving_tile: ")

	moving_tile.emit(is_moving)


func _on_mouse_object_tile_released() -> void:
	if !Game.grid_tile_hovered:
		return
	Game.grid_tile_hovered.pressed.emit()


func _on_slot_machine_play_sound() -> void: 
	#print_debug("_on_slot_machine_play_lever_sound...")
	
	slot_machine_sound.emit()
