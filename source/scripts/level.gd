extends Node2D

signal return_to_menu

func _on_main_menu_pressed() -> void:
	
	emit_signal("return_to_menu")
	
	pass

func _on_restart_pressed() -> void:
	
	print_debug("currently does nothing...")
	
	pass
