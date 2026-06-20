class_name SlotMachine

signal lever_pulled
signal finished

var _ui: SlotMachineUI
var _wheels: Array[SlotWheel] = []
var _selected: SlotWheel
var _awaiting: int
var _color_count: int = 1

#var _blocked: bool = false

func set_ui(new_ui: SlotMachineUI) -> void:
	_ui = new_ui
	_ui.spin_requested.connect(_on_lever_pulled)


func set_wheel_count(count: int, color_count: int = 1) -> void:
	_color_count = color_count
	var wheels: Array[SlotWheel] = []
	for i in count:
		var wheel = SlotWheel.new()
		wheel.slot_wheel_pressed.connect(select_wheel)
		wheels.append(wheel)
	_wheels = wheels
	_ui.populate_wheels(wheels)
	for wheel in _wheels:
		wheel.set_resource(BombResource.new())
		wheel.finished.connect(_wheel_finished)


func spin_wheels() -> void:
	_awaiting = _wheels.size()
	for i in range(_wheels.size() - 1, -1, -1):
		var wheel = _wheels[i]
		wheel.spin(_color_count)
		await Game.get_tree().create_timer(0.25).timeout
		if !is_instance_valid(_ui):
			return


func _wheel_finished():
	_awaiting -= 1
	if _awaiting <= 0:
		finished.emit()
		Game.slot_machine_blocked_flag = false
		if is_instance_valid(_ui):
			_ui.set_blocked(false)


func select_wheel(wheel: SlotWheel) -> void:
	_selected = wheel


func get_selected_item() -> ItemResource:
	if !_selected:
		return null
	return _selected.get_reward()


func consume_selected() -> void:
	_selected.set_resource(null)


func _on_lever_pulled():
	if Game.slot_machine_blocked_flag:
		_ui.shake_lever()
		return

	Game.slot_machine_blocked_flag = true
	_ui.set_blocked(true)
	_ui.pull_lever()
	spin_wheels()
	lever_pulled.emit()
