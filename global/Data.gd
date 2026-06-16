extends Node

var version_game = "2026.0605.01"
var version_cfg = 0

#var default_save = OS.get_unique_id()
#var setting_save = default_save


#var music_volume = 50
#var sfx_volume = 50 

var settings_loaded = false

var default_position = Vector2( 100, 100 )
var default_transition = 0.0

var default_volume_sfx    = 25
var default_volume_music  = 25
var default_music_enabled = true
var default_sfx_enabled = true

var default_theme  = "default"
var default_music_type = 1

var setting_position = default_position
var setting_transition = default_transition

var setting_volume_music = default_volume_music
var setting_volume_sfx = default_volume_sfx

var setting_music_enabled = default_music_enabled
var setting_sfx_enabled = default_sfx_enabled

var setting_music_type = default_music_type
var setting_theme      = default_theme


func _ready():
	
	# pass quit notification to main
	get_tree().set_auto_accept_quit(false)
	
	#data_load()
	
	pass

func _notification(what):
	
	# save data when the game exits
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		
		setting_position = get_window().position
		
		data_save()
		
		get_tree().quit()
		
		pass
	
	pass

func data_save():
	#print_debug("data_save...")
	
	# initiate config file 
	var config = ConfigFile.new()  
#	var _err = config.load("user://settings.cfg")
	
	config.set_value("version", "version", version_game)
	#config.set_value("save", "setting_save", setting_save)
	
	config.set_value("settings", "setting_position", setting_position)
	config.set_value("settings", "setting_transition", setting_transition)
	
	config.set_value("settings", "setting_volume_sfx", setting_volume_sfx)
	config.set_value("settings", "setting_volume_music", setting_volume_music)
	
	config.set_value("settings", "setting_music_enabled", setting_music_enabled)
	config.set_value("settings", "setting_sfx_enabled", setting_sfx_enabled)
	
	#config.set_value("settings", "setting_volume_master", setting_volume_master)
	
	#print_debug("save setting_music_enabled: " + str(setting_music_enabled) )
	#print_debug("save setting_sfx_enabled: " + str(setting_sfx_enabled) )
	
	config.set_value("settings", "setting_music_type", setting_music_type)
	config.set_value("settings", "setting_theme", setting_theme)
	
	# save config file 
	config.save("user://settings.cfg")
	
	pass

func data_load(): 
	#print_debug("data_load...")
	
	# load config file data 
	var config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	
	# If the file didn't load, ignore it.
	if err != OK:
		print_debug("err != OK")
		settings_loaded = true
		return
	
	version_cfg          = config.get_value("version", "version", 0)
	
	setting_position     = config.get_value("settings", "setting_position", default_position)
	setting_transition   = config.get_value("settings", "setting_transition", default_transition)
	
	setting_volume_sfx   = config.get_value("settings", "setting_volume_sfx", default_volume_sfx)
	setting_volume_music = config.get_value("settings", "setting_volume_music", default_volume_music)
	
	setting_music_enabled = config.get_value("settings", "setting_music_enabled", default_music_enabled)
	setting_sfx_enabled   = config.get_value("settings", "setting_sfx_enabled", default_sfx_enabled)
	
	#setting_volume_master       = config.get_value("settings", "setting_volume_master", default_volume_master)
	
	#print_debug("load setting_music_enabled: " + str(setting_music_enabled) )
	#print_debug("load setting_volume_music: " + str(setting_volume_music) )
	
	#print_debug("load setting_sfx_enabled: " + str(setting_sfx_enabled) )
	#print_debug("load setting_volume_sfx: " + str(setting_volume_sfx) )
	
	setting_theme       = config.get_value("settings", "setting_theme", default_theme)
	setting_music_type  = config.get_value("settings", "setting_music_type", default_music_type)
	
	#print_debug("load setting_music_type: " + str(setting_music_type) )
	#print_debug("load setting_theme: " + str(setting_theme) )
	
	#print_debug("load setting_volume: " + str(default_volume) )
	
	settings_loaded = true
	
	pass
