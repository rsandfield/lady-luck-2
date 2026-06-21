class_name SpinnerUI
extends Control

signal finished

var _colors: Array[Color]
var _item_uis: Array[ItemUI]
var _awaiting: int = 0


func _ready():
	$InnerWheel.finished.connect(_spin_finished)
	$OuterWheel.finished.connect(_spin_finished)


func set_row_count(count: int) -> void:
	var colors = GridUI.ROW_COLORS.slice(1, count)
	$OuterWheel.make_pie(colors)


func set_items(items: Array[ItemResource]) -> void:
	_item_uis = []
	_item_uis.resize(len(items))

	_colors = []
	for item in items:
		_colors.append(item.wheel_color())

	var i = 0
	for item in items:
		set_item(item, i)
		i += 1


func set_item(item: ItemResource, index: int):
	if _item_uis[index]:
		_item_uis[index].queue_free()

	_colors[index] = item.wheel_color()
	$InnerWheel.make_pie(_colors)

	var item_scene = item.ui_scene()
	if !item_scene:
		_item_uis[index] = null
		return

	var item_ui = item_scene.instantiate()
	_item_uis[index] = item_ui
	if item_ui.has_method("set_resource"):
		item_ui.set_resource(item)
	$InnerWheel.add_child(item_ui)

	item_ui.scale = Vector2.ONE * 0.25
	var rot = index * TAU / len(_item_uis)
	var offset = 0.25 * TAU / len(_item_uis)

	item_ui.pivot_offset = Vector2.ONE * 0.5
	item_ui.position = Vector2.UP.rotated(rot - offset) * 45 + Vector2.ONE * 100
	item_ui.rotation = rot


func clear_ui(index: int):
	if _item_uis[index]:
		_item_uis[index].queue_free()


func spin_to(outer: int, inner: int, extra_rotations: int = 3):
	_awaiting = 2
	$OuterWheel.spin(outer, extra_rotations)
	$InnerWheel.spin(inner, extra_rotations, false)


func _spin_finished():
	_awaiting -= 1
	if _awaiting > 0:
		return
	finished.emit()
