class_name MouseDetection
extends Control

signal mouse_clicked( is_clicked : bool, mouse_position : Vector2 )
signal mouse_moved( mouse_position : Vector2 )

var mouse_is_clicked : bool = false


func _on_gui_input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton:
		#print_debug( str(event ) )
		if event.pressed: 
			mouse_clicked.emit(true, event.position)
			mouse_is_clicked = true
		if !event.pressed: 
			mouse_clicked.emit(false, event.position)
			mouse_is_clicked = false
	
	if mouse_is_clicked: 
		#print_debug( str(event.position ) )
		mouse_moved.emit(event.position)
	
	pass
