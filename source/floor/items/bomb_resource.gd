class_name BombResource
extends ItemResource


func is_legal_play(cell: GridCell) -> bool:
	return cell.is_occupied() && !cell.is_door() && !cell.is_fixed


func play(slot: GridCell) -> void:
	slot.clear()


func ui_scene() -> PackedScene:
	return preload("./bomb_ui.tscn")
