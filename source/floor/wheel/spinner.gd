class_name Spinner

signal result(row: int, item: ItemResource)

@export var p_none := 0.4
@export var p_bomb := 0.3
@export var p_tile_single := 0.3

var _ui: SpinnerUI
var _row_count: int
var _color_count: int
var _items: Array[ItemResource]


func set_ui(new_ui: SpinnerUI) -> void:
	_ui = new_ui


func set_row_count(count: int) -> void:
	_row_count = count
	_ui.set_row_count(count)


func set_item_count(item_count: int, color_count: int = 2) -> void:
	_color_count = color_count
	_items = []
	for i in item_count:
		_items.append(_new_item())
	_ui.set_items(_items)


func spin():
	if !is_instance_valid(_ui):
		return
	var row = randi() % _row_count
	var item_index = randi() % len(_items)
	_ui.spin_to(row + _row_count * 3, -item_index - len(_items) * 3)

	await _ui.finished
	if !is_instance_valid(_ui):
		return
	_ui.clear_ui(item_index)
	result.emit(row, _items[item_index])

	await Game.get_tree().create_timer(1).timeout
	if !is_instance_valid(_ui):
		return
	_ui.set_item(_new_item(), item_index)


func _new_item() -> ItemResource:
	var f := randf_range(0, p_none + p_bomb + p_tile_single)
	f -= p_none
	if f <= 0:
		return ItemResource.new()
	f -= p_bomb
	if f <= 0:
		return BombResource.new()
	f -= p_tile_single
	if f <= 0:
		return TileResource.random_two_side(_color_count)
	return ItemResource.new()
