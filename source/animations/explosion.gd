extends Node2D



func _on_call_explode() -> void: 
	
	$AnimationPlayer.play("explode")
	
	pass

func _on_call_reset() -> void: 
	
	$AnimationPlayer.play("RESET")
	
	pass
