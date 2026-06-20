class_name Floor
extends PanelContainer


@export var _levels: Array[FloorConfig]

@onready var _turn_counter: TurnContainer = %TurnContainer
@onready var _points_counter: PointsContainer = %PointContainer
@onready var _victory: Node2D = $Victory

var _level: int = 0
var _config: FloorConfig = FloorConfig.new()
var _slot_machine: SlotMachine
var _grid: Grid
var _spinner: Spinner
var _lady: LadyLuck


signal moving_tile(is_clicked: bool)
signal slot_machine_sound


func _ready():
	reset(_levels[0])


func reset(config: FloorConfig = null, reset_score: bool = true):
	_victory.visible = false
	if config:
		_config = config

	Game.neighbor_validation = _config.neighbor_validation
	_config.spinner_rewards.set_color_count(_config.color_count)
	_config.slot_rewards.set_color_count(_config.color_count)

	_slot_machine = SlotMachine.new()
	_slot_machine.set_ui(%SlotMachine)
	_slot_machine.set_wheel_count(_config.wheel_count, _config.slot_rewards)
	_slot_machine.finished.connect(_on_spin_finished)

	var grid_size = _config.grid_size + Vector2i.DOWN
	_grid = Grid.new()
	_grid.set_ui(%Grid)
	_grid.grid_cell_pressed.connect(_on_grid_cell_pressed)
	_grid.set_grid_size(grid_size, _config.color_count)

	_spinner = Spinner.new()
	_spinner.set_ui(%Spinner)
	_spinner.set_row_count(grid_size.y)
	_spinner.set_item_count(_config.spinner_item_count, _config.spinner_rewards)
	_slot_machine.lever_pulled.connect(_on_lever_pulled)

	_lady = LadyLuck.new()
	_lady.set_ui(%LadyLuck)
	_lady.set_grid(_grid)
	_spinner.result.connect(_on_lady_play)

	_turn_counter.set_value(0)
	if reset_score:
		_points_counter.set_value(0)


func _on_grid_cell_pressed(slot: GridCell) -> void:
	var item = _slot_machine.get_selected_item()
	if !item:
		return
	if !slot.is_legal_play(item):
		return

	item.play(slot)
	_slot_machine.consume_selected()

	if _grid.all_paths_finished():
		_grid.activate_door().connect(_on_door_pressed)


func cheat_win() -> void:
	_victory.visible = true


func _on_door_pressed(_slot: GridCell) -> void:
	_level += 1
	if _level >= len(_levels):
		_victory.visible = true
		return
	reset(_levels[_level], false)


#var for_testing = true
func _on_lever_pulled():
	#print_debug("_on_lever_pulled...")
	#if for_testing: return
	#print_debug("here...")
	
	_grid.flag_spin(true)
	_spinner.spin()
	_turn_counter.add_value(1)
	
	#_points_counter.emit_generate_confetti()
	

func _on_spin_finished():
	#print_debug("_on_spin_finished...")
	
	_grid.flag_spin(false)
	_grid.flash_all_flags()
	
	_points_counter.emit_generate_confetti()


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
	
	#if Game.slot_machine_blocked_flag: return
	
	slot_machine_sound.emit()
