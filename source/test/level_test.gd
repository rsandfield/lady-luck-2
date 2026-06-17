extends Level


@onready var _mouse_object : MouseObject = $MouseObject


func _on_move_mouse_object( _mouse_new_position : Vector2 ): 
	
	$MouseObject.position = _mouse_new_position
	
	pass

func _on_floor_mouse_clicked(_is_clicked: bool, _mouse_position: Vector2) -> void:
	
	_mouse_object.position = _mouse_position
	
	pass

func _on_floor_moving_tile( is_moving : bool ) -> void:
	
	if  is_moving: _mouse_object.show()
	if !is_moving: _mouse_object.hide()
	
	pass
