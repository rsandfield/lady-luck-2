class_name ItemSlot

signal slot_pressed(slot: ItemSlot)

var _resource: ItemResource


func is_occupied() -> bool:
	return _resource != null


func get_resource() -> ItemResource:
	return _resource


func is_legal_play(item: ItemResource) -> bool:
	return item.is_legal_play(self)


func set_resource(_new_resource: ItemResource) -> void:
	push_error("ItemSlot subclasses must override set_resource()")


func clear() -> void:
	_resource = null


func press() -> void:
	slot_pressed.emit(self)
