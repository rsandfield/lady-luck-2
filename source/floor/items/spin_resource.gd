class_name SpinResource
extends ItemResource

@export var clockwise: bool = true


static func random_spin() -> SpinResource:
	var s := SpinResource.new()
	s.clockwise = randi() % 2 == 0
	return s


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
		return
	if slot is GridCell:
		var cell := slot as GridCell
		var tile := cell.get_tile() as TileResource
		if !tile:
			return
		var sides := tile.get_sides()
		if clockwise:
			sides = [sides[3], sides[0], sides[1], sides[2]]
		else:
			sides = [sides[1], sides[2], sides[3], sides[0]]
		tile.set_sides(sides)
		cell.set_tile(tile)


func ui_scene() -> PackedScene:
	return preload("./spin_ui.tscn")


func wheel_color() -> Color:
	return Color.YELLOW
