class_name ItemUI
extends PanelContainer

const TILE_COLOR_SHOW = Color(1.0, 1.0, 1.0, 1.0)
const TILE_COLOR_HIDE = Color(0.0, 0.0, 0.0, 0.0)

var tile_is_moving = false


func set_visible_is_moving(is_moving: bool, modulate_color: Color) -> void:
	tile_is_moving = is_moving
	set_self_modulate(modulate_color)
