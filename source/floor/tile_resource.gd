class_name TileResource
extends Resource

enum Direction {
	NORTH,
	EAST,
	SOUTH,
	WEST
}

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

static func random_two_side() -> TileResource:
	var side_indices = [0, 1, 2, 3]
	side_indices.shuffle()
	var sides: Array[int] = [0, 0, 0, 0]
	sides[side_indices[0]] = 1
	sides[side_indices[1]] = 1
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


func is_legal_neighbor(direction: Direction, neighbor: TileResource) -> bool:
	if !neighbor:
		return true
	return _sides[direction] == neighbor.get_side(opposite(direction))
