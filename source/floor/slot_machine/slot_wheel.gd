class_name SlotWheel


signal slot_wheel_pressed(wheel: SlotWheel)


var _ui: SlotWheelUI
var _tile: TileResource


func set_ui(new_ui: SlotWheelUI):
	_ui = new_ui
	_ui.pressed.connect(_pressed)


func spin() -> void:
	_tile = TileResource.random_two_side()
	set_resource(_tile)


func set_resource(resource: TileResource) -> void:
	_tile = resource
	_ui.populate(_tile)


func get_reward() -> TileResource:
	return _tile


func _pressed() -> void:
	slot_wheel_pressed.emit(self)
