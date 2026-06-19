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


func is_legal_play(cell: GridCell) -> bool:
	for direction in Direction.values():
		var neighbor = cell.get_neighbor(direction)
		if !neighbor:
			if get_side(direction) > 0:
				return false
			continue
		if !neighbor.is_legal_neighbor(opposite(direction), self):
			return false
	return true


func is_legal_neighbor(direction: Direction, neighbor: TileResource) -> bool:
	if !neighbor:
		return true
	return _sides[direction] == neighbor.get_side(opposite(direction))


func play(slot: GridCell) -> void:
	slot.set_tile(self)


func ui_scene() -> PackedScene:
	return preload("./tile_ui.tscn")


func wheel_color() -> Color:
	return Color.GREEN
