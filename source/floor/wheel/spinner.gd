class_name Spinner


var _ui: SpinnerUI
var _row_count: int
var _items: Array[ItemResource]


func set_ui(new_ui: SpinnerUI) -> void:
	_ui = new_ui


func set_row_count(count: int) -> void:
	_row_count = count
	_ui.set_row_count(count)


func set_items(items: Array[ItemResource]) -> void:
	_items = items
	_ui.set_items(items)


func spin():
	var row = randi() % _row_count
	var item_index = randi() % len(_items)
	_ui.spin_to(row + _row_count * 2, -item_index - len(_items) * 3)
