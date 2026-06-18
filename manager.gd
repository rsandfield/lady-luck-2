extends Control

var manager_state : String = "Start"

var default_window_height = ProjectSettings.get_setting("display/window/size/viewport_height")
var default_window_width = ProjectSettings.get_setting("display/window/size/viewport_width") 

signal data_loaded


func _ready():
	
	Data.data_load()
	emit_signal("data_loaded")
	
	_set_window_position()
	_set_transition_time()
	
	pass

func _check_manager_state() -> void: 
	
	if manager_state == "Start" || manager_state == "Test" || manager_state == "Alt" : 
		
		if manager_state == "Start": 
			$Start.show()
			$TestLevel.hide()
			$TestAltLevel.hide()
		if manager_state == "Test": 
			$Start.hide()
			$TestLevel.show()
			$TestAltLevel.hide()
		if manager_state == "Alt": 
			$Start.hide()
			$TestLevel.hide()
			$TestAltLevel.show()
			
		$Level.hide()
		$Credits.hide()
		$Options.hide()
		if Game.debug_enabled: 
			$Debug.show()
	
	if manager_state == "Level" : 
		$Level.show()
		$Start.hide()
		$Debug.hide()
	
	if manager_state == "Credits": 
		$Credits.show()
	
	if manager_state == "Options": 
		$Options.show()
	
	pass

func _on_transitions_animation_finished(anim_name: StringName) -> void:
	#print_debug( "Manager: " + anim_name )
	
	if anim_name == "fadein":
		_check_manager_state() 
		%Transitions.play( "fadeout", -1, 1.0 / Data.default_transition )
		
		# change to this if you want the user to be able to control the transition time
		#%Transitions.play( "fadeout", -1, 1.0 / Data.setting_transition )
	
	pass

func _on_return_to_menu() -> void: 
	
	manager_state = "Start"
	_on_play_transition()
	
	pass

func _on_start_new_game() -> void:
	
	manager_state = "Level"
	_on_play_transition()
	
	pass

func _on_start_show_options() -> void:
	
	manager_state = "Options"
	_on_play_transition()
	
	pass

func _on_start_show_credits() -> void:
	
	manager_state = "Credits"
	_on_play_transition()
	
	pass

func _on_play_transition() -> void:
	#print_debug( "_on_transition_test_pressed... " )
	#print_debug("transition: " + str(Data.setting_transition) )
	
	# hard code the transition speed to be 0.5
	%Transitions.play( "fadein", -1, 1.0 / Data.default_transition )
	
	# if we are allowing the user to change the fade in speed
	# then use the code below
	#if Data.setting_transition > 0: 
		#%Transitions.play( "fadein", -1, 1.0 / Data.setting_transition )
	#else: 
		#_check_manager_state()
	
	pass

func _set_window_position(): 
	#print_debug("_on_set_window_position...")
	
	# starts minimized and transparent to hide the startup transition
	# set the mode to windowed and set the last user set position at startup
	
	get_window().mode = Window.Mode.MODE_WINDOWED
	
	get_window().borderless = false
	get_window().transparent = false
	
	# window size changes when you add or remove borderless
	# use this line to look and see what it is before and/or after
	#print_debug( "get_window().size: " + str( get_window().size ) )
	
	# update this if you want to implement or save user selected resolution options
	get_window().size = Vector2( default_window_width, default_window_height )
	
	# finally, move the window to the position where you want it to start
	get_window().position = Data.setting_position
	
	pass

func _set_transition_time(): 
	#print_debug("_set_transition_time: " + str(Data.setting_transition) )
	
	$Debug._on_change_transition_pressed( true, Data.setting_transition )
	
	pass


func _on_start_quit_appliation() -> void:
	
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	
	pass


func _on_test_game() -> void:
	
	manager_state = "Test"
	_on_play_transition()
	
	pass # Replace with function body.
	
func _on_test_alt_game() -> void:
	#print_debug("_on_test_alt_game... " )
	
	manager_state = "Alt"
	_on_play_transition()
	
	pass # Replace with function body.
