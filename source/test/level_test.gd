extends Level


@onready var _mouse_object : MouseObject = $MouseObject

signal slots_sound ( sound_type : String )


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


func _on_switch_pressed() -> void:
	
	$LadyLuckLight.visible = $LadyLuckDark.visible
	$LadyLuckDark.visible = !$LadyLuckLight.visible
	
	pass

func _on_slots_sound( sound_type : String ) -> void: 
	
	slots_sound.emit( sound_type )
	
	pass
