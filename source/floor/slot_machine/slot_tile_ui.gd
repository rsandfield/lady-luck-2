class_name SlotTileUI
extends Control

signal finished

var tile_ui: TileUI


func move_to(to: float, time: float = 0.25) -> void:
	var tween = create_tween()
	tween.tween_property(
		self, "position", Vector2(0, to), time
	).set_trans(
		Tween.TRANS_LINEAR
	).set_ease(
		Tween.EASE_IN_OUT
	)
	tween.finished.connect(finished.emit)


func move_by(by: float, time: float = 0.25) -> void:
	move_to(position.y + by, time)


func spin_up(time: float = 0.25) -> void:
	move_by(75, time)


func spin_down(time: float = 0.25) -> void:
	move_by(-75, time)
