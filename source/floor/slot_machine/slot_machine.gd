class_name SlotMachine

signal lever_pulled
signal finished

var _ui: SlotMachineUI
var _wheels: Array[SlotWheel] = []
var _selected: SlotWheel
var _awaiting: int
var _reward_config: RewardConfig
var _get_bomb_budget: Callable = func(): return 0

#var _blocked: bool = false

func set_ui(new_ui: SlotMachineUI) -> void:
	_ui = new_ui
	_ui.spin_requested.connect(_on_lever_pulled)


func set_wheel_count(count: int, reward_config: RewardConfig = RewardConfig.new()) -> void:
	_reward_config = reward_config
	var wheels: Array[SlotWheel] = []
	for i in count:
		var wheel = SlotWheel.new()
		wheel.slot_wheel_pressed.connect(select_wheel)
		wheels.append(wheel)
	_wheels = wheels
	_ui.populate_wheels(wheels)
	for wheel in _wheels:
		wheel.set_resource(ItemResource.new())
		wheel.finished.connect(_wheel_finished)


func set_bomb_budget_source(source: Callable) -> void:
	_get_bomb_budget = source


func _generate_results() -> Array[ItemResource]:
	var bomb_budget: int = _get_bomb_budget.call()
	var results: Array[ItemResource] = []
	for wheel in _wheels:
		results.append(_reward_config.get_item())

	var bomb_count = 0
	for i in results.size():
		if results[i] is BombResource:
			bomb_count += 1
			if bomb_count > bomb_budget:
				results[i] = _non_bomb_result()

	return results


func _non_bomb_result() -> ItemResource:
	for i in 10:
		var item = _reward_config.get_item()
		if !(item is BombResource):
			return item
	return ItemResource.new()


func spin_wheels() -> void:
	var results = _generate_results()

	_awaiting = _wheels.size()
	for i in range(_wheels.size() - 1, -1, -1):
		_wheels[i].spin(results[i], _reward_config)
		await Game.get_tree().create_timer(0.25).timeout
		if !is_instance_valid(_ui):
			return


func _wheel_finished():
	_awaiting -= 1
	if _awaiting <= 0:
		finished.emit()



func select_wheel(wheel: SlotWheel) -> void:
	_selected = wheel


func get_selected_item() -> ItemResource:
	if !_selected:
		return null
	return _selected.get_reward()


func consume_selected() -> void:
	_selected.set_resource(null)


func _on_lever_pulled():
	if Game.slot_machine_blocked_flag:
		_ui.shake_lever()
		return

	_selected = null
	Game.slot_machine_blocked_flag = true
	#Game.slot_machine_give_points = true
	_ui.set_blocked(true)
	_ui.pull_lever()
	spin_wheels()
	lever_pulled.emit()
