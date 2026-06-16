extends Node2D


#@onready var _mouse_object : MouseObject = $MouseObject

signal return_to_menu

#var mouse_last_position : Vector2 = Vector2(0.0,0.0)
#


func _on_move_mouse_object( _mouse_new_position : Vector2 ): 
	
	$MouseObject.position = _mouse_new_position
	
	pass

func _on_main_menu_pressed() -> void:
	
	emit_signal("return_to_menu")
	
	pass

func _on_restart_pressed() -> void:
	
	print_debug("currently does nothing...")
	
	pass

func _on_mouse_clicked(is_clicked: bool, _mouse_position: Vector2) -> void:
	print_debug( "_on_mouse_clicked: ")
	
	if is_clicked: $MouseObject.show()
	if !is_clicked: $MouseObject.hide()
	
		#$MouseObject.position = mouse_position
	
	pass
