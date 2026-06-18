class_name Floor
extends PanelContainer


@export var _size: Vector2i = Vector2i(5, 7)
@export var _wheels := 4

var _slot_machine: SlotMachine
var _grid: Grid
var _spinner: Spinner
var _lady: LadyLuck

signal moving_tile ( is_clicked : bool )


func _ready():
	_slot_machine = SlotMachine.new()
	_slot_machine.set_ui(%SlotMachine)
	_slot_machine.set_wheel_count(_wheels)
	
	_grid = Grid.new()
	_grid.set_ui(%Grid)
	_grid.grid_cell_pressed.connect(_on_grid_cell_pressed)
	_grid.set_grid_size(_size)

	_spinner = Spinner.new()
	_spinner.set_ui(%Spinner)
	_spinner.set_row_count(_size.y)
	_spinner.set_item_count(6)
	_slot_machine.lever_pulled.connect(_spinner.spin)

	_lady = LadyLuck.new()
	_lady.set_grid(_grid)
	_spinner.result.connect(_lady.cause_chaos)


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


func _on_slot_machine_moving_tile( is_moving : bool ) -> void:
	#print_debug( "_on_slot_machine_moving_tile: ")
	
	moving_tile.emit( is_moving )


func _on_mouse_object_tile_released() -> void:
	if !Game.grid_tile_hovered:
		return
	Game.grid_tile_hovered.pressed.emit()
