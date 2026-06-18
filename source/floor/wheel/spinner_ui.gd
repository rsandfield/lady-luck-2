class_name SpinnerUI
extends Control

var _item_uis: Array[ItemUI]

func set_row_count(count: int) -> void:
	var colors = GridUI.ROW_COLORS.slice(1, count)
	$OuterWheel.make_pie(colors)


func set_items(items: Array[ItemResource]) -> void:
	_item_uis = []
	_item_uis.resize(len(items))

	var colors: Array[Color] = []
	for item in items:
		colors.append(item.wheel_color())
	$InnerWheel.make_pie(colors)

	var i = 0
	for item in items:
		set_item(item, i)
		i += 1


func set_item(item: ItemResource, index: int):
	var item_scene = item.ui_scene()
	if !item_scene:
		_item_uis[index] = null
		return

	var item_ui = item_scene.instantiate()
	_item_uis[index] = item_ui
	item_ui.set_resource(item)
	$InnerWheel.add_child(item_ui)

	item_ui.scale = Vector2.ONE * 0.25
	var rot = index * TAU / len(_item_uis)
	var offset = 0.25 * TAU / len(_item_uis)

	item_ui.pivot_offset = Vector2.ONE * 0.5
	item_ui.position = Vector2.UP.rotated(rot - offset) * 45 + Vector2.ONE * 100
	item_ui.rotation = rot


func spin_to(outer: int, inner: int):
	$OuterWheel.spin(outer)
	$InnerWheel.spin(inner)
