class_name BombResource
extends ItemResource


func is_legal_play(slot: ItemSlot) -> bool:
	if slot is HandSlot:
		return !slot.is_occupied()
	if slot is GridCell:
		var cell := slot as GridCell
		return cell.is_occupied() && !cell.is_door() && !cell.is_fixed
	return false


func play(slot: ItemSlot) -> void:
	if slot is HandSlot:
		slot.set_tile(self)
	elif slot is GridCell:
		(slot as GridCell).explode()


func ui_scene() -> PackedScene:
	return preload("./bomb_ui.tscn")


func wheel_color() -> Color:
	return Color.PURPLE
