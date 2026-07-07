class_name HandSlot
extends ItemSlot

var _ui: HandSlotUI


func set_ui(new_ui: HandSlotUI) -> void:
	_ui = new_ui
	if !_ui.is_node_ready():
		await _ui.ready
	_ui.pressed.connect(_pressed)
	_ui.hovered.connect(_on_hovered)
	_ui.moving_tile.connect(_on_moving_tile)


func set_resource(resource: ItemResource) -> void:
	_resource = resource
	_ui.set_resource(resource)


func clear() -> void:
	_ui.set_resource(null)
	super.clear()


func press() -> void:
	slot_pressed.emit(self)


func position() -> Vector2:
	return _ui.global_position + _ui.size / 2


func size() -> Vector2:
	return _ui.size


func _pressed() -> void:
	press()


func _on_hovered(is_hovered: bool) -> void:
	if is_hovered:
		Game.grid_tile_hovered = self
	elif Game.grid_tile_hovered == self:
		Game.grid_tile_hovered = null


func _on_moving_tile(is_moving: bool) -> void:
	if is_moving:
		Game.moving_tile_source = self
