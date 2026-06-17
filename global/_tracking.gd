extends Node

var changelog = [

"""

Errors:

---------------------------------------------
::: Template :::
---------------------------------------------


Reported 2024.04XX: 
Status: New / Tracking / Testing Fix / Unknown / Fixed
Godot: ...
Issue: ...
Cause: ...


---------------------------------------------
::: New / Tracking :::
---------------------------------------------

Reported 2024.04XX: 
Status: New
Godot: 3.5.3
Cause: Unknown
( probably due to audio source changes, headphones to speakers or vice versa... )
( also possibly due to running in the background while the app was minimized... )
W 3:15:32.286   thread_func: WASAPI: Current device invalidated, closing device
  <C++ Source>  drivers/wasapi/audio_driver_wasapi.cpp:651 @ thread_func()


Reported 2024.0305: 
Status: New
Issue: Error being thrown in console when the sewer level starts up
Cause: Particle and shaders have issues being created using threads
( probably same issue as others, related to the shaders being used in the sewers... )

	control_level: level_sewer
	At: res://source/Application/Scripts/Manager.gd:311:control_level()
	1 | // NOTE: Shader automatically converted from Godot Engine 3.5.3.stable's ParticlesMaterial.
	SHADER ERROR: Unknown identifier in expression: color_ramp
		  at: (null) (:167)


Reported: 2024.0215: 
Status: Tracking / Unknown
Issue: Crash
Cause: it looks like muffins can be removed at the same time they are being moved around in the tree
( muffin_arena.move_child( self, rng_range ) , where rng_range is out of bounds...? )
( var rng_range = rng.randi_range( 0, muffin_arena.get_child_count() ) , child count no longer valid )
( should try testing with max/100 muffins per round for a large number of rounds )

	E 9:31:08.353   remove: Index p_index = 8 is out of bounds (size() = 8).
	  <C++ Source>  ./core/cowdata.h:158 @ remove()
	  <Stack Trace> Muffin.gd:379 @ random_position()
					Muffin.gd:618 @ consume_lives()
					Molly.gd:273 @ _on_Impact_area_exited()


Reported: 2024.0212: 
Status: Tracking / Unknown
( seen shortly after starting the town level, testing for ~4 hours ) 
( i suspect that this a godot engine bug, but might also be a muffin destruction issue )
( should try testing with max/100 muffins per round for a large number of rounds )
possibly related: https://github.com/godotengine/godot/issues/77565
	
	ERROR: Index p_index = 2 is out of bounds (size() = 2).
	  at: remove (./core/cowdata.h:158) - Index p_index = 2 is out of bounds (size() = 2).


Reported: 2024.0212: 
Updated: 2024.0422
Status: Tracking / Unknown
Issue: Connection failed on first attempt
Browser: Vivaldi
Cause: Unknown, possibly the browser, maybe Twitch hand off
( I was streaming to Twitch at the time, might also be browser issue )
	control_level: level_menu
	
	*** this section is failure ***
	
	Listening on 127.0.0.1:58811...
	auth_key.size: 1
	Stopped listening....
	
	*** end section comment ***
	
	Listening on 127.0.0.1:58811...
	auth_key.size: 1
	Stopped listening....
	channel: marsbattery
	Connected to Twitch.



---------------------------------------------
::: Testing Fix :::
---------------------------------------------


Reported: 2024.0214
Status: Testing Fix 
Fixed: 2023.0214.01+ -> a check to only yield if launching more than one at a time has been added
Issue: not sure when this race condition is being met as the arena script should always be around
Cause: this yield function should only really occur when launching a large number of muffins at once
	
	thread_completed
	   At: res://source/Application/Scripts/Manager.gd:265:thread_complete()
	ERROR: Resumed function '_on_Launch_pressed()' after yield, but script is gone. 
	At script: res://source/Objects/Levels/Arena/Arena.gd:263
	   at: (modules/gdscript/gdscript_function.cpp:1795)
	increment_muffins_killed, value: 9


---------------------------------------------
::: Fixed / No Longer Tracking :::
---------------------------------------------


Reported: 2024.0201:
Fixed: 2023.0214.01+ -> moved particle object creation for shop/actors to outside of thread
Status: Fixed / No Longer Tracking
Issue: Error being thrown usually when the stop level starts up
( might be caused by particle generation at level startup, shop? )
( probably a threading issue, creating particles during thread creation... )
( tried to fix in 2024.0212.02+ build )
( still occurring in 2024.0213.01+, but less frequently, perhaps another object was missed? )
( testing a fix after removing the charge and discharge particles on marvin )
suspected: https://github.com/godotengine/godot/issues/23684
	
	SHADER ERROR: (null): Unknown identifier in expression: color_ramp
	SHADER ERROR: Unknown identifier in expression: color_ramp
		  at: (null) (:165)


Reported: 2024.0213: 
Fixed: 2023.0214.01+ -> moved particle object creation for shop/actors to outside of thread
Status: Fixed / No Longer Tracking
Issue: Error being thrown usually when the stop level starts up
Cause: Particle and shaders have issues being created using threads
	
	control_level: level_shop
	   At: res://source/Application/Scripts/Manager.gd:307:control_level()
		1 | // NOTE: Shader automatically converted from Godot Engine 3.5.3.stable's ParticlesMaterial.
	SHADER ERROR: Unknown identifier in expression: tex_orbit_velocity
			  at: (null) (:136)
	thread_completed


Reported: 2023.02XX:
Fixed: 2023.0212.03 -> moved particle object creation for bearclaw/castle to outside of thread
Status: Fixed / No Longer Tracking
Issue: Error being thrown usually when the castle level starts up
( could this be related to the unassigned image? ) 
( probably a threading issue, creating particles during thread creation... )
suspected: https://github.com/godotengine/godot/issues/23684
	
	E 0:01:31.689   Unknown identifier in expression: emission_sphere_radius
	  <C++ Source>  :110


---------------------------------------------
::: Not Reported Recently :::
---------------------------------------------

Reported: 2023.02XX:
Status: Unknown / Fixed
( fixed? possibly due to export var image not being assigned in menu link object )
( still seeing this error... maybe related to the intro video somehow..? ) 
( this was possibly a godot engine issue fixed in the 3.5+ branch ) 

	E 0:00:02.529   create: Expected Image data size of 100x1x4 (without mipmaps) = 400 bytes, got 8192 bytes instead.
	  <C++ Error>   Method failed.
	  <C++ Source>  core/image.cpp:1784 @ create()
	E 0:00:02.535   texture_set_data: Condition "texture->format != p_image->get_format()" is true.
	  <C++ Source>  drivers/gles3/rasterizer_storage_gles3.cpp:709 @ texture_set_data()


Reported 2023.02XX:
Status: Unknown / Fixed
( similar to the issue above, possibly fixed )
( this was possibly a godot engine issue fixed in the 3.5+ branch ) 

	ERROR: Expected Image data size of 100x1x4 (without mipmaps) = 400 bytes, got 8192 bytes instead.
	   at: (core/image.cpp:1784)
	ERROR: Condition "texture->format != p_image->get_format()" is true.
	   at: texture_set_data (drivers/gles3/rasterizer_storage_gles3.cpp:709)


Reported 2023.02XX:
Status: Unknown / Fixed
( possibly audio driver issue? ) 
( this was possibly a godot engine issue fixed in the 3.5+ branch ) 
	
	Crash: WARNING: WASAPI: Unsupported number of channels: 1
	https://github.com/godotengine/godot/issues/76504
	https://github.com/godotengine/godot/issues/25875
	https://github.com/godotengine/godot/pull/76541   -> fixed 4.0.3


Reported 2023.02XX:
Status: Unknown / Fixed
( this error is a little too generic to debug with the given information ) 
	
	At: res://source/Network/Scripts/connection.gd:97:server_start()
	Twitch, _on_Authorize, get_request https://id.twitch.tv/oauth2/authorize?client_id=<...>
	&redirect_uri=https://muffintourlegacy.com/auth&response_type=token&scope=chat:read
	error, auth_key.size: 1
	At: res://source/Network/Scripts/connection.gd:79:get_connection_twitch()
	Stopped listening....


---------------------------------------------


"""

]


