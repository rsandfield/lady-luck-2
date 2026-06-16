extends Node2D


@onready var game_version = %Version

signal start_test_game
signal start_new_game
signal show_options
signal show_credits
signal quit_appliation

signal volume_changed
signal play_test_sound
signal restart_music
signal update_music


func _ready():
	
	#Data.data_load()
	#_set_window_position()
	_display_game_version()
	
	_set_music_slider( Data.setting_volume_music )
	_set_sounds_slider( Data.setting_volume_sfx )
	
	
	pass

func _display_game_version(): 
	
	game_version.text = "version: " + Data.version_game
	
	pass

func _on_manager_data_loaded():
	#print_debug("_on_manager_data_loaded...")
	
	_on_set_sound_controls()
	_update_theme()
	_update_music()
	
	pass

func _on_new_game_pressed() -> void:
	
	emit_signal( "start_new_game" )
	
	pass


func _on_test_game_pressed() -> void:
	
	emit_signal( "start_test_game" )
	
	pass

func _on_options_pressed() -> void:
	
	emit_signal( "show_options" )
	
	pass


func _on_credits_pressed() -> void:
	
	emit_signal( "show_credits" )
	
	pass

func _on_exit_pressed() -> void:
	
	emit_signal( "quit_appliation" )
	
	pass

func _set_music_slider( music_volume: int ) -> void: 
	#print_debug("_set_music_slider: " + str( music_volume ) )
	
	%MusicSlider.value = music_volume
	%MusicLevel.text = str(music_volume) + "%"
	
	pass

func _set_sounds_slider( sound_volume: int ) -> void: 
	#print_debug("_set_mu_set_sounds_slider: " + str( sound_volume ) )
	
	%SoundsSlider.value = sound_volume
	%SoundsLevel.text = str(sound_volume) + "%"
	
	pass

func _on_music_slider_value_changed(value: float) -> void:
	
	Data.setting_music_enabled = true
	Data.setting_volume_music = value
	_on_set_sound_controls()
	
	pass

func _on_sounds_slider_value_changed(value: float) -> void:
	
	Data.setting_sfx_enabled = true
	Data.setting_volume_sfx = value
	_on_set_sound_controls()
	
	pass

func _on_music_button_toggled(toggled_on: bool) -> void:
	#print_debug("_on_sounds_button_toggled: " + str(toggled_on))
	
	Data.setting_music_enabled = toggled_on
	_on_set_sound_controls()
	
	pass

func _on_sounds_button_toggled(toggled_on: bool) -> void:
	#print_debug("_on_sounds_button_toggled: " + str(toggled_on))
	
	Data.setting_sfx_enabled = toggled_on
	_on_set_sound_controls()
	
	pass

func _on_set_sound_controls(): 
	#print_debug("_on_set_sound_controls...")
	
	%MusicButton.set_pressed_no_signal(Data.setting_music_enabled)
	%SoundsButton.set_pressed_no_signal(Data.setting_sfx_enabled)
	
	%MusicPanel.visible = !Data.setting_music_enabled
	%SoundPanel.visible = !Data.setting_sfx_enabled
	
	%MusicSlider.set_value_no_signal( Data.setting_volume_music )
	%SoundsSlider.set_value_no_signal( Data.setting_volume_sfx )
	
	%MusicLevel.text = str( int(Data.setting_volume_music) ) + "%"
	%SoundsLevel.text = str( int(Data.setting_volume_sfx) ) + "%"
	
	emit_signal( "volume_changed" )
	
	pass
	
func _on_music_restart_pressed() -> void:
	
	emit_signal( "restart_music" )
	
	pass

func _on_sound_test_pressed() -> void:
	
	emit_signal( "play_test_sound" )
	
	pass

func _on_sounds_slider_drag_ended(_value_changed: bool) -> void:
	
	_on_sound_test_pressed()
	
	pass

func _on_button_theme_change( new_theme: String ) -> void:
	#print_debug("_on_button_theme_change: " + new_theme )
	
	Data.setting_theme = new_theme
	_update_theme()
	
	pass

func _update_theme() -> void:
	#print_debug("_update_theme: " + Data.setting_theme )
	
	var theme_normal = "res://assets/themes/style_box_flat_grey_default.tres"
	var theme_hover = "res://assets/themes/style_box_flat_grey_default_hover.tres"
	
	if Data.setting_theme == "blue": 
		theme_normal = "res://assets/themes/style_box_flat_blue_light.tres"
		theme_hover = "res://assets/themes/style_box_flat_blue_light_hover.tres"
	if Data.setting_theme == "green": 
		theme_normal = "res://assets/themes/style_box_flat_green_light.tres"
		theme_hover = "res://assets/themes/style_box_flat_green_light_hover.tres"
	if Data.setting_theme == "purple": 
		theme_normal = "res://assets/themes/style_box_flat_purple_light.tres"
		theme_hover = "res://assets/themes/style_box_flat_purple_light_hover.tres"
	
	var m_theme = load("res://assets/themes/current_theme.tres")
	
	m_theme.set( "Button/styles/disabled", load(theme_normal) )
	m_theme.set( "Button/styles/focus", load(theme_normal) )
	m_theme.set( "Button/styles/hover", load(theme_hover) )
	m_theme.set( "Button/styles/normal", load(theme_normal) )
	m_theme.set( "Button/styles/pressed", load(theme_normal) )
	
	pass

func _on_music_pressed(track: int) -> void:
	#print_debug("_on_music_pressed: " + str(track) )
	
	Data.setting_music_type = track
	_update_music()
	
	pass

func _update_music() -> void:
	
	$MarginContainer/SoundControl/MusicButton/Music1/Panel.visible = (Data.setting_music_type == 1)
	$MarginContainer/SoundControl/MusicButton/Music2/Panel.visible = (Data.setting_music_type == 2)
	$MarginContainer/SoundControl/MusicButton/Music3/Panel.visible = (Data.setting_music_type == 3)
	
	emit_signal("update_music")
	
	pass
