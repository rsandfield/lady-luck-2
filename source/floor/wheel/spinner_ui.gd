class_name SpinnerUI
extends Control


func set_row_count(count: int) -> void:
	var colors = GridUI.ROW_COLORS.slice(1, count)
	$OuterWheel.make_pie(colors)


func set_items(items: Array[ItemResource]) -> void:
	var colors: Array[Color] = []
	for item in items:
		colors.append(item.wheel_color())
	$InnerWheel.make_pie(colors)

	var i = 0
	for item in items:
		var item_scene = item.ui_scene()
		if !item_scene:
			i += 1
			continue
		var item_ui = item_scene.instantiate()
		item_ui.set_resource(item)
		$InnerWheel.add_child(item_ui)
		item_ui.scale = Vector2.ONE * 0.25
		var rot = i * TAU / len(items)
		var derp = 0.25 * TAU / len(items)
		item_ui.pivot_offset = Vector2.ONE * 0.5
		item_ui.position = Vector2.UP.rotated(rot - derp) * 45 + Vector2.ONE * 100
		item_ui.rotation = rot
		i += 1



func spin_to(outer: int, inner: int):
	$OuterWheel.spin(outer)
	$InnerWheel.spin(inner)
