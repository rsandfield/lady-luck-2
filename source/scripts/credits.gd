extends Node2D

signal return_to_menu


func _on_back_pressed() -> void:
	emit_signal("return_to_menu")

	pass


func _on_pigsquad_pressed() -> void:
	OS.shell_open("https://pigsquad.com/summerslowjams")

	pass


func _on_godot_pressed() -> void:
	OS.shell_open("https://godotengine.org")

	pass
