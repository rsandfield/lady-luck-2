class_name Flag
extends Control


var color: Color:
	set(value):
		color = value
		$TextureRect.modulate = color
		$Glow.modulate = Color(color, 0)


var flip: bool:
	set(value):
		flip = value
		$TextureRect.flip_h = value
		if flip:
			$Glow.position.x = 0
		else:
			$Glow.position.x = -7.5


func pulse(time: float):
	var tween = get_tree().create_tween()
	tween.tween_property($Glow, "modulate", color, time / 2)
	tween.tween_property($Glow, "modulate", Color(color, 0), time / 2)
