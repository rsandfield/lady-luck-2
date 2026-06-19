class_name Level
extends Node2D

signal return_to_menu
signal restart_game


func _on_main_menu_pressed() -> void:
	print_debug("_on_main_menu_pressed...")

	emit_signal("return_to_menu")

	pass


func _on_restart_pressed() -> void:
	emit_signal("restart_game")
