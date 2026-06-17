class_name SlotWheel


signal slot_wheel_pressed(wheel: SlotWheel)


var _ui: SlotWheelUI
var _tile: TileResource


func set_ui(new_ui: SlotWheelUI):
	_ui = new_ui
	_ui.pressed.connect(_pressed)


func spin() -> void:
	var tiles: Array[TileResource] = []
	for i in 8:
		tiles.append(TileResource.random_two_side())
	_tile = tiles[0]
	_ui.spin(tiles)


func set_resource(resource: TileResource) -> void:
	_tile = resource
	_ui.populate(_tile)


func get_reward() -> TileResource:
	return _tile


func _pressed() -> void:
	slot_wheel_pressed.emit(self)
