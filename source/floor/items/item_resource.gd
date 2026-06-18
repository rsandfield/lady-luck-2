class_name ItemResource
extends Resource


func ui_scene() -> PackedScene:
	push_error("All item resource types must override ui_scene()")
	return null


func is_legal_play(_cell: GridCell) -> bool:
	push_error("All item resource types must override is_legal_play()")
	return false


func play(_slot: GridCell) -> void:
	push_error("All item resource types must override play()")
