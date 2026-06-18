extends Level


@onready var _mouse_object : MouseObject = $MouseObject

signal slots_sound ( sound_type : String )


func _process(_delta: float) -> void:
	
	if !self.visible && %Tutorial.visible: %Tutorial.hide()
	
	pass

func _input(_event: InputEvent) -> void:
	
	if Input.is_action_just_pressed("ui_help"): 
		#print_debug("test_level: ui_help...")
		
		_on_help_pressed()
		
		pass
	
	if Input.is_action_just_pressed("ui_retry"): 
		#print_debug("test_level: ui_retry...")
		
		emit_signal("restart_game")
		
		pass
	
	if Input.is_action_just_pressed("ui_cancel"):
		#print_debug("test_level: ui_cancel...")
		
		if %Tutorial.visible: 
			%Tutorial.hide()
		
		elif self.visible: 
			return_to_menu.emit()
	
	pass

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

var switch_luck = 0 
func _on_switch_pressed() -> void:
	
	switch_luck += 1
	if switch_luck >= 3: switch_luck = 0
	
	$LadyLuckColor.visible = switch_luck == 0
	$LadyLuckLight.visible = switch_luck == 1
	$LadyLuckDark.visible = switch_luck == 2
	
	pass

func _on_slots_sound( sound_type : String ) -> void: 
	
	slots_sound.emit( sound_type )
	
	pass


func _on_help_pressed() -> void:
	
	if    %Tutorial.visible: %Tutorial.hide()
	elif !%Tutorial.visible: %Tutorial._on_show_self()
	
	pass
