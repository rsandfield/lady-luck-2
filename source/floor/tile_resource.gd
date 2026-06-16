class_name TileResource
extends Resource

@export var _sides: Array[int] = []

static func random_two_side() -> TileResource:
	var side_indices = [0, 1, 2, 3]
	side_indices.shuffle()
	var sides: Array[int] = [0, 0, 0, 0]
	sides[side_indices[0]] = 1
	sides[side_indices[1]] = 1
	return TileResource.new(sides)


func _init(sides: Array[int]):
	set_sides(sides)

func set_sides(new_sides: Array[int]) -> void:	
	_sides = new_sides


func get_sides() -> Array[int]:
	return _sides
