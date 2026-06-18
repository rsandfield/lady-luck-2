class_name SlotMachine


var _ui: SlotMachineUI
var _wheels: Array[SlotWheel] = []
var _selected: SlotWheel


func set_ui(new_ui: SlotMachineUI) -> void:
	_ui = new_ui
	_ui.spin_requested.connect(spin_wheels)


func set_wheel_count(count: int) -> void:
	var wheels: Array[SlotWheel] = []
	for i in count:
		var wheel = SlotWheel.new()
		wheel.slot_wheel_pressed.connect(select_wheel)
		wheels.append(wheel)
	_wheels = wheels
	_ui.populate_wheels(wheels)
	for wheel in _wheels:
		wheel.set_resource(BombResource.new())


func spin_wheels() -> void:
	for i in range(_wheels.size() - 1, -1, -1):
		var wheel = _wheels[i]
		wheel.spin()
		await _ui.get_tree().create_timer(0.5).timeout


func select_wheel(wheel: SlotWheel) -> void:
	_selected = wheel


func get_selected_item() -> ItemResource:
	if !_selected:
		return null
	return _selected.get_reward()


func consume_selected() -> void:
	_selected.set_resource(null)
