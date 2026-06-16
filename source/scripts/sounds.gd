extends Node2D


var track_1 = "res://assets/sound/track_1_hyperfishation.mp3"
var track_2 = "res://assets/sound/track_2_melodys_melodies.mp3"
var track_3 = "res://assets/sound/track_3_just_a_feeling.mp3"


func _ready():
	
	%Music.play()
	
	pass

func _on_start_play_test_sound() -> void:
	
	%Chime.play()
	
	pass

func _on_start_restart_music() -> void:
	
	%Music.play()
	
	pass

func _on_start_update_music() -> void:
	
	_set_music_track()
	
	pass

func _set_sound_level() -> void: 
	#print_debug("_set_sound_level... " )
	
	var setting_volume_music_db = linear_to_db( Data.setting_volume_music ) - 40
	var setting_volume_sfx_db = linear_to_db( Data.setting_volume_sfx ) - 40
	
	AudioServer.set_bus_volume_db( AudioServer.get_bus_index("Music"), setting_volume_music_db )
	AudioServer.set_bus_volume_db( AudioServer.get_bus_index("SFX"), setting_volume_sfx_db )
	
	if Data.setting_volume_music == 0 || !Data.setting_music_enabled : 
		AudioServer.set_bus_mute( AudioServer.get_bus_index("Music"), true )
	
	if Data.setting_volume_sfx == 0 || !Data.setting_sfx_enabled : 
		AudioServer.set_bus_mute( AudioServer.get_bus_index("SFX"), true )
#	
	if AudioServer.is_bus_mute( AudioServer.get_bus_index("Music") ) && Data.setting_music_enabled: 
		AudioServer.set_bus_mute( AudioServer.get_bus_index("Music"), false )
	
	if AudioServer.is_bus_mute( AudioServer.get_bus_index("SFX") ) && Data.setting_sfx_enabled: 
		AudioServer.set_bus_mute( AudioServer.get_bus_index("SFX"), false )
	
	pass

func _set_music_track() -> void:
	#print_debug("_set_music_track: " + str(Data.setting_music_type) )
	
	if Data.setting_music_type == 1 : %Music.stream = load(track_1) 
	if Data.setting_music_type == 2 : %Music.stream = load(track_2) 
	if Data.setting_music_type == 3 : %Music.stream = load(track_3) 
	
	%Music.play()
	
	pass
