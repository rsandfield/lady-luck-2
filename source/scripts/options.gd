extends Node2D

signal return_to_menu

func _on_back_pressed() -> void:
	
	emit_signal("return_to_menu")
	
	pass
