extends Node2D

signal complete_retry
signal complete_menu
signal complete_credits


func _on_play_again_pressed() -> void:
	complete_retry.emit()
	queue_free()
	
	pass


func _on_menu_pressed() -> void:
	#print_debug("_on_menu_pressed...")
	
	complete_credits.emit()
	
	## wait to queue free until after it is no longer visible
	$AnimationPlayer.play("wait_queue_free")
	
	pass


func _on_credits_pressed() -> void:
	#print_debug("_on_credits_pressed...")
	
	complete_menu.emit()
	
	## wait to queue free until after it is no longer visible
	$AnimationPlayer.play("wait_queue_free")
	
	pass
