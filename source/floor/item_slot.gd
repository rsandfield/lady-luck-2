class_name ItemSlot

signal slot_pressed(slot: ItemSlot)

var _tile: ItemResource


func is_occupied() -> bool:
	return _tile != null


func get_tile() -> ItemResource:
	return _tile


func is_legal_play(item: ItemResource) -> bool:
	return item.is_legal_play(self)


func set_tile(_new_tile: ItemResource) -> void:
	push_error("ItemSlot subclasses must override set_tile()")


func clear() -> void:
	_tile = null


func press() -> void:
	slot_pressed.emit(self)
