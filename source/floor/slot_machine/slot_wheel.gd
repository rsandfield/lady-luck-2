class_name SlotWheel

signal slot_wheel_pressed(wheel: SlotWheel)
signal finished

var _ui: SlotWheelUI
var _item: ItemResource


func set_ui(new_ui: SlotWheelUI):
	_ui = new_ui
	_ui.pressed.connect(_pressed)


func spin() -> void:
	var items: Array[ItemResource] = []
	for i in 8:
		items.append(TileResource.random_two_side())
	items.append(BombResource.new())
	items.shuffle()
	_item = items[-2]
	if !is_instance_valid(_ui):
		return
	await _ui.spin(items)
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
