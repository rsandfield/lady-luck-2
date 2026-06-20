class_name SlotWheel

signal slot_wheel_pressed(wheel: SlotWheel)
signal finished

var _ui: SlotWheelUI
var _item: ItemResource


func set_ui(new_ui: SlotWheelUI):
	_ui = new_ui
	_ui.pressed.connect(_pressed)


func spin(result: ItemResource, reward_config: RewardConfig) -> void:
	_item = result
	var items: Array[ItemResource] = []
	for i in 9:
		items.append(reward_config.get_item())
	items[-2] = result
	if !is_instance_valid(_ui):
		return
	await _ui.spin(items, reward_config)
	if !is_instance_valid(_ui):
		return
	finished.emit()


func set_resource(resource: ItemResource) -> void:
	_item = resource
	if resource:
		_ui.populate(_item)
	else:
		_ui.clear_center()


func get_reward() -> ItemResource:
	return _item


func _pressed() -> void:
	slot_wheel_pressed.emit(self)
