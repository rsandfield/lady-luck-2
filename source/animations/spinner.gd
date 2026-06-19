extends Control


func _on_button_0_pressed() -> void:
	$AnimationPlayer.play("RESET")

	pass


func _on_button_1_pressed() -> void:
	$AnimationPlayer.play("RESET")
	$AnimationPlayer.queue("spinner")

	pass


func _on_button_2_pressed() -> void:
	$AnimationPlayer.play("RESET")
	$AnimationPlayer.queue("paper")

	pass


func _on_button_3_pressed() -> void:
	$AnimationPlayer.play("RESET")
	$AnimationPlayer.queue("slots")

	pass
