extends Node2D

signal test_transitions


func _on_change_transition_pressed( _toggled_on: bool, transition_time: float ) -> void:
	
	#print_debug("pressed: " + str(_toggled_on) + ", " + str(transition_time) )
	
	Data.setting_transition = transition_time
	
	%CheckBox1s.set_pressed_no_signal(    transition_time == 1.0 )
	%CheckBox500ms.set_pressed_no_signal( transition_time == 0.5 )
	%CheckBox100ms.set_pressed_no_signal( transition_time == 0.1 )
	%CheckBox0s.set_pressed_no_signal(    transition_time == 0.0 )
	
	pass

func _on_test_transitions_pressed() -> void:
	
	emit_signal( "test_transitions" )
	
	pass

func _on_label_gui_input(event: InputEvent, transition_time: float ) -> void:
	
	if event is InputEventMouseButton : 
		_on_change_transition_pressed( true, transition_time )
	
	#if event is InputEventMouseButton && transition_time == 1.0 : pass
	#if event is InputEventMouseButton && transition_time == 0.5 : pass
	#if event is InputEventMouseButton && transition_time == 0.1 : pass
	#if event is InputEventMouseButton && transition_time == 0.0 : pass
	
	pass

func _on_test_user_data_folder_pressed() -> void:
	
	#https://docs.godotengine.org/en/stable/tutorials/io/data_paths.html
	
	#Windows: %APPDATA%\Godot\app_userdata\[project_name]
	#macOS: ~/Library/Application Support/Godot/app_userdata/[project_name]
	#Linux: ~/.local/share/godot/app_userdata/[project_name]
	
	OS.shell_open( ProjectSettings.globalize_path("user://") )
	
	pass
