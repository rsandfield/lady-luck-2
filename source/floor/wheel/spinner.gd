class_name Spinner


var _ui: SpinnerUI
var _row_count: int
var _items: Array[ItemResource]


func set_ui(new_ui: SpinnerUI) -> void:
	_ui = new_ui
	_ui.get_node("Button").pressed.connect(spin)


func set_row_count(count: int) -> void:
	_row_count = count
	_ui.set_row_count(count)


func set_items(items: Array[ItemResource]) -> void:
	_items = items
	_ui.set_items(items)


func spin():
	var row = randi_range(_row_count * 2, _row_count * 3 - 1)
	var item_index = randi_range(len(_items), len(_items) * 2 - 1)
	_ui.spin_to(row, -item_index)
