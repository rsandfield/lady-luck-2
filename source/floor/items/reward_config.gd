class_name RewardConfig
extends Resource

@export var p_none := 0.2
@export var p_bomb := 0.5
@export var p_tile_single := 0.3
@export var p_tile_two_color := 0.0
@export var p_brush := 0.0

var _color_count: int = 1


func set_color_count(color_count: int) -> void:
	_color_count = color_count


func get_item() -> ItemResource:
	var total := p_none + p_bomb + p_tile_single + p_tile_two_color + p_brush
	var f := randf_range(0, total)
	f -= p_none
	if f <= 0:
		return ItemResource.new()
	f -= p_bomb
	if f <= 0:
		return BombResource.new()
	f -= p_tile_single
	if f <= 0:
		return TileResource.random_two_side(_color_count)
	f -= p_tile_two_color
	if f <= 0:
		return TileResource.random_two_color(_color_count)
	f -= p_brush
	if f <= 0:
		return BrushResource.random_brush(_color_count)
	return ItemResource.new()