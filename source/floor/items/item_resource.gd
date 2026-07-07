class_name ItemResource
extends Resource


func ui_scene() -> PackedScene:
	return preload("./item_ui.tscn")


func is_legal_play(_slot: ItemSlot) -> bool:
	return false


func play(_slot: ItemSlot) -> void:
	push_error("All item resource types must override play()")


func wheel_color() -> Color:
	return Color.WHITE
