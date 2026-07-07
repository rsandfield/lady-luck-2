class_name TileResource
extends ItemResource

enum Direction { NORTH, EAST, SOUTH, WEST }


static func opposite(direction: Direction) -> Direction:
	match direction:
		Direction.NORTH:
			return Direction.SOUTH
		Direction.SOUTH:
			return Direction.NORTH
		Direction.EAST:
			return Direction.WEST
		Direction.WEST:
			return Direction.EAST
	return Direction.NORTH


var is_door: bool = false

@export var _sides: Array[int] = []


static func random_two_side(possible_colors: int = 2) -> TileResource:
	var color := randi() % possible_colors + 1
	var sides: Array[int] = [0, 0, color, color]
	sides.shuffle()
	return TileResource.new(sides)


static func random_two_color(possible_colors: int = 2) -> TileResource:
	if possible_colors < 2:
		return random_two_side(1)
	
	var color1 := randi() % possible_colors + 1
	var color2 := randi() % possible_colors + 1
	if color1 == color2:
		color2 += 1
		if color2 > possible_colors:
			color2 -= possible_colors
	var sides: Array[int] = [color1, color1, color2, color2]
	sides.shuffle()
	return TileResource.new(sides)


static func blank() -> TileResource:
	var sides: Array[int] = [0, 0, 0, 0]
	return TileResource.new(sides)


func _init(sides: Array[int]):
	set_sides(sides)


func set_sides(new_sides: Array[int]) -> void:
	_sides = new_sides


func get_sides() -> Array[int]:
	return _sides


func get_side(direction: Direction) -> int:
	return _sides[direction]


func is_legal_play(slot: ItemSlot) -> bool:
	if slot is HandSlot:
		return !slot.is_occupied()
	if slot is GridCell:
		var cell := slot as GridCell
		if !Game.neighbor_validation:
			return !cell.is_occupied()
		for direction in Direction.values():
			var neighbor = cell.get_neighbor(direction)
			if !neighbor:
				if get_side(direction) > 0:
					return false
				continue
			if !neighbor.is_legal_neighbor(opposite(direction), self):
				return false
		return true
	return false


func is_legal_neighbor(direction: Direction, neighbor: TileResource) -> bool:
	if !neighbor:
		return true
	if !Game.neighbor_validation:
		return true
	return _sides[direction] == neighbor.get_side(opposite(direction))


func play(slot: ItemSlot) -> void:
	slot.set_resource(self)


func ui_scene() -> PackedScene:
	return preload("./tile_ui.tscn")


func wheel_color() -> Color:
	return Color.GREEN
