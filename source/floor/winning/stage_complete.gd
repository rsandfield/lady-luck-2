extends Node2D

signal complete_retry
signal complete_menu
signal complete_credits


func _on_play_again_pressed() -> void:
	complete_retry.emit()
	queue_free()
	
	pass


func _on_menu_pressed() -> void:
	complete_menu.emit()
	queue_free()
	
	pass


func _on_credits_pressed() -> void:
	complete_credits.emit()
	queue_free()
	
	pass
