class_name Floor
extends PanelContainer


@export var _size: Vector2i = Vector2i(5, 7)

var _slot_machine: SlotMachine
var _grid: Grid


func _ready():
	_slot_machine = SlotMachine.new()
	_slot_machine.set_ui(%SlotMachine)
	_slot_machine.set_wheel_count(4)

	_grid = Grid.new()
	_grid.set_ui(%Grid)
	_grid.grid_cell_pressed.connect(_on_grid_cell_pressed)

	_grid.set_grid_size(_size)


func _on_grid_cell_pressed(slot: GridCell) -> void:
	if slot.is_occupied():
		return

	var item = _slot_machine.get_selected_item()
	slot.set_tile(item)	
	_slot_machine.consume_selected()
