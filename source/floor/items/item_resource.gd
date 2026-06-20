class_name ItemResource
extends Resource


func ui_scene() -> PackedScene:
	return preload("./item_ui.tscn")


func is_legal_play(_cell: GridCell) -> bool:
	return false


func play(_slot: GridCell) -> void:
	push_error("All item resource types must override play()")


func wheel_color() -> Color:
	return Color.WHITE
