class_name Level
extends Node2D

signal return_to_menu
signal restart_game

signal slots_sound(sound_type: String)


func _on_main_menu_pressed() -> void:
	print_debug("_on_main_menu_pressed...")

	emit_signal("return_to_menu")


func _on_restart_pressed() -> void:
	print_debug("_on_restart_pressed...")

	emit_signal("restart_game")


func _on_help_pressed() -> void:
	print_debug("_on_help_pressed...")
	
	if %Tutorial.visible:
		%Tutorial.hide()
	elif !%Tutorial.visible:
		%Tutorial._on_show_self()


func _on_slots_sound(sound_type: String = "slots2") -> void:
	slots_sound.emit(sound_type)

	pass


func _on_mouse_object_tile_released() -> void:
	pass
