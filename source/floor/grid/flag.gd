class_name Flag
extends Control

var color: Color:
	set(value):
		color = value
		$Bulb.modulate = color
		$Glow.modulate = Color(color, 0)

var flip: bool:
	set(value):
		flip = value
		$Lightbulb.flip_h = value
		# if flip:
		# 	$Glow.position.x = 0
		# else:
		# 	$Glow.position.x = -7.5


func disable():
	for child in get_children():
		child.visible = false


func pulse(time: float):
	var tween = create_tween()
	tween.tween_property($Glow, "modulate", color, time / 2)
	tween.tween_property($Glow, "modulate", Color(color, 0), time / 2)
