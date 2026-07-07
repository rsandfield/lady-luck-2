class_name ShovelResource
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
		slot.set_resource(self)
		return
	if slot is GridCell:
		var cell := slot as GridCell
		var tile := cell.get_resource()
		if !tile:
			return
		cell.clear()
		Game.moving_tile_source.set_resource(tile)
		Game.moving_tile_source = null


func ui_scene() -> PackedScene:
	return preload("./shovel_ui.tscn")


func wheel_color() -> Color:
	return Color.SADDLE_BROWN
