class_name BrushResource
extends ItemResource

@export var color: int


static func random_brush(_color_count) -> BrushResource:
	var b := BrushResource.new()
	b.color = randi() % _color_count + 1
	return b


func is_legal_play(slot: ItemSlot) -> bool:
	if slot is HandSlot:
		return !slot.is_occupied()
	if slot is GridCell:
		var cell := slot as GridCell
		if !cell.is_occupied() || cell.is_door() || cell.is_fixed:
			return false
		var tile := cell.get_resource() as TileResource
		if !tile:
			return false
		# Can't play if tile is single-color and already matches brush
		var non_zero_colors: Array[int] = []
		for s in tile.get_sides():
			if s != 0 && s not in non_zero_colors:
				non_zero_colors.append(s)
		if non_zero_colors.size() == 1 && non_zero_colors[0] == color:
			return false
		return true
	return false


func play(slot: ItemSlot) -> void:
	if slot is HandSlot:
		slot.set_resource(self)
		return
	if slot is GridCell:
		var cell := slot as GridCell
		var tile := cell.get_resource() as TileResource
		if !tile:
			return
		var sides := tile.get_sides()
		# Find distinct non-zero colors
		var has_brush_color := color in sides
		if has_brush_color:
			# Swap: find the other color and swap them
			var other_color := -1
			for s in sides:
				if s != 0 && s != color:
					other_color = s
					break
			if other_color >= 0:
				for i in sides.size():
					if sides[i] == color:
						sides[i] = other_color
					elif sides[i] == other_color:
						sides[i] = color
		else:
			# Replace North's color with brush color
			var north_color := sides[0]
			if north_color != 0:
				for i in sides.size():
					if sides[i] == north_color:
						sides[i] = color
		tile.set_sides(sides)
		cell.set_resource(tile)


func ui_scene() -> PackedScene:
	return preload("./brush_ui.tscn")


func wheel_color() -> Color:
	return Color.ORANGE

