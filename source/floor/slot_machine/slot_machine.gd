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


func spin_wheels() -> void:
	for wheel in _wheels:
		wheel.spin()


func select_wheel(wheel: SlotWheel) -> void:
	print("Selecting")
	_selected = wheel


func get_selected_item() -> TileResource:
	if !_selected:
		print("No wheel selected")
		return null
	print("Wheel selected")
	return _selected.get_reward()


func consume_selected() -> void:
	_selected.set_resource(null)
