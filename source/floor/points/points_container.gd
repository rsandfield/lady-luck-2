extends Control

const points_confetti_reference = preload("res://source/floor/points/points_confetti.tscn")


var points_tracking = 0

func _on_change_points( new_points : int ) -> void:
	#print_debug( "_on_change_points: " + str( extra_arg_0 ) )
	
	var rand = randi_range(1,49)
	
	points_tracking += new_points - rand 
	
	_on_parse_points()
	
	#print_debug( "points_tracking: " + str( points_tracking ) )
	
	var new_points_confetti = points_confetti_reference.instantiate()
	new_points_confetti.position = $Marker2D.position
	add_child( new_points_confetti )
	new_points_confetti._set_points_info( new_points - rand  )
	
	pass

func _on_parse_points(): 
	
	var str_points = str( points_tracking )
	
	%Points1._set_number( 0 )
	%Points2._set_number( 0 )
	%Points3._set_number( 0 )
	%Points4._set_number( 0 )
	%Points5._set_number( 0 )
	%Points6._set_number( 0 )
	
	if points_tracking > 99999: %Points1._set_number( int( str_points[ str_points.length() - 6 ] ) )
	if points_tracking > 9999:  %Points2._set_number( int( str_points[ str_points.length() - 5 ] ) )
	if points_tracking > 999:   %Points3._set_number( int( str_points[ str_points.length() - 4 ] ) )
	if points_tracking > 99:    %Points4._set_number( int( str_points[ str_points.length() - 3 ] ) )
	if points_tracking > 9:     %Points5._set_number( int( str_points[ str_points.length() - 2 ] ) )
	if points_tracking > 0:     %Points6._set_number( int( str_points[ str_points.length() - 1 ] ) )
	
	#print_debug( str_points.length() )
	#print_debug( str_points[ str_points.length() - 1 ] )
	
	if points_tracking > 999999: 
		%Points1._set_number( 9 )
		%Points2._set_number( 9 )
		%Points3._set_number( 9 )
		%Points4._set_number( 9 )
		%Points5._set_number( 9 )
		%Points6._set_number( 9 )
	
	if points_tracking < 0: 
		%Points1._set_number( 0 )
		%Points2._set_number( 0 )
		%Points3._set_number( 0 )
		%Points4._set_number( 0 )
		%Points5._set_number( 0 )
		%Points6._set_number( 0 )
	
	pass
