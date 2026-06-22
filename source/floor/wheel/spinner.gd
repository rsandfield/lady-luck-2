class_name Spinner

signal result(row: int, item: ItemResource)

var _ui: SpinnerUI
var _row_count: int
var _reward_config: RewardConfig
var _items: Array[ItemResource]


func set_ui(new_ui: SpinnerUI) -> void:
	_ui = new_ui


func set_row_count(count: int) -> void:
	_row_count = count - 1
	_ui.set_row_count(count)


func set_item_count(item_count: int, reward_config: RewardConfig = RewardConfig.new()) -> void:
	_reward_config = reward_config
	_items = []
	for i in item_count:
		_items.append(_reward_config.get_item())
	_ui.set_items(_items)


func spin():
	if !is_instance_valid(_ui):
		return
	var row = randi() % _row_count
	var item_index = randi() % len(_items)
	_ui.spin_to(row, item_index)

	await _ui.finished
	if !is_instance_valid(_ui):
		return
	_ui.clear_ui(item_index)
	result.emit(row, _items[item_index])

	await Game.get_tree().create_timer(1).timeout
	if !is_instance_valid(_ui):
		return
	var new_item = _reward_config.get_item()
	_items[item_index] = new_item
	_ui.set_item(new_item, item_index)
