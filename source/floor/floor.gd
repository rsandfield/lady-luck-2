class_name Floor
extends PanelContainer


@export var _levels: Array[FloorConfig]

@onready var _turn_counter: TurnContainer = %TurnContainer
@onready var _points_counter: PointsContainer = %PointContainer
#@onready var _victory: Node2D = $Victory

var _level: int = 0
var _config: FloorConfig = FloorConfig.new()
var _slot_machine: SlotMachine
var _grid: Grid
var _spinner: Spinner
var _lady: LadyLuck
var _hand: HandSlot


signal moving_tile(is_clicked: bool)
signal slot_machine_sound


func _ready():
	reset(_levels[0])


func reset(config: FloorConfig = null, reset_score: bool = true):
	#_victory.visible = false
	if config:
		_config = config

	Game.slot_machine_blocked_flag = false
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
	_grid.grid_cell_pressed.connect(_on_slot_pressed)
	_grid.set_grid_size(grid_size, _config.color_count)
	_slot_machine.set_bomb_budget_source(_grid.count_bombable_tiles)

	_spinner = Spinner.new()
	_spinner.set_ui(%Spinner)
	_spinner.set_row_count(grid_size.y)
	_spinner.set_item_count(_config.spinner_item_count, _config.spinner_rewards)
	_slot_machine.lever_pulled.connect(_on_lever_pulled)

	_hand = HandSlot.new()
	_hand.set_ui(%HandSlot)
	_hand.slot_pressed.connect(_on_slot_pressed)
	%HandSlot.moving_tile.connect(_on_slot_machine_moving_tile)

	_lady = LadyLuck.new()
	_lady.set_ui(%LadyLuck)
	_lady.set_grid(_grid)
	_spinner.result.connect(_on_lady_play)

	_turn_counter.set_value(0)
	if reset_score:
		_points_counter.set_value(0)


func _on_slot_pressed(slot: ItemSlot) -> void:
	if !Game.moving_tile_source:
		return
	var item := Game.moving_tile_source.get_resource()
	if !item:
		return
	if !slot.is_legal_play(item):
		return

	item.play(slot)
	if Game.moving_tile_source:
		Game.moving_tile_source.clear()
	Game.moving_tile_source = null

	if slot is GridCell and _grid.all_paths_finished():
		_grid.activate_door().connect(_on_door_pressed)


func create_victory_screen() -> void:
	
	var stage_complete_scene = load( "res://source/floor/winning/stage_complete.tscn" )
	var stage_complete_instance = stage_complete_scene.instantiate()
	add_child( stage_complete_instance )
	
	stage_complete_instance.complete_retry.connect(reset)
	stage_complete_instance.complete_menu.connect(_on_game_over_menu)
	stage_complete_instance.complete_credits.connect(_on_game_over_credits)


func _on_game_over_credits() -> void:
	Game.change_state_machine = "menu"
	
	pass

func _on_game_over_menu() -> void:
	Game.change_state_machine = "credits"
	
	pass


func _on_door_pressed(_slot: GridCell) -> void:
	_level += 1
	
	if _level >= len(_levels):
		#_victory.visible = true
		# do win condition creation stuff
		create_victory_screen()
		
		return
	
	reset(_levels[_level], false)


func _on_lever_pulled():
	
	_grid.flag_spin(true)
	_lady.clear_held()
	_spinner.spin()
	_turn_counter.add_value(1)
	
	# fake the timing here, instead of _on_spin_finished
	await get_tree().create_timer(2.0).timeout
	_points_counter.emit_generate_confetti()

func _on_spin_finished():
	#print_debug("_on_spin_finished...")
	
	_grid.flag_spin(false)
	_grid.flash_all_flags()
	
	# should really do this here...
	# but the first spinner stops before this is called
	#_points_counter.emit_generate_confetti()


func _on_lady_play(row: int, item: ItemResource):
	_grid.pulse_row(row)
	await _lady.cause_chaos(row, item)
	Game.slot_machine_blocked_flag = false
	%SlotMachine.set_blocked(false)


func _on_slot_machine_moving_tile(is_moving: bool) -> void:
	#print_debug( "_on_slot_machine_moving_tile: ")

	moving_tile.emit(is_moving)


func _on_mouse_object_tile_released() -> void:
	if !Game.grid_tile_hovered:
		return
	Game.grid_tile_hovered.press()


func _on_slot_machine_play_sound() -> void: 
	#print_debug("_on_slot_machine_play_lever_sound...")
	
	slot_machine_sound.emit()


func _on_level_restart_game() -> void:
	
	reset()
	
	pass
