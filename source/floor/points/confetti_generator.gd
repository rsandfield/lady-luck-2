class_name ConfettiGenerator
extends Node2D

const POINTS_CONFETTI_SCENE = preload("res://source/floor/points/points_confetti.tscn")

signal update_points_display(points_added: int)


func _on_new_confetti(new_points: int) -> void:
	#print_debug( "_on_change_points: " + str( new_points ) )
	
	for _points_location in %ConfettiMarkers.get_children(): 
		
		randomize()
		var rand = randi_range(-1200, 200)
		var _randomized_points = new_points - rand
		
		await get_tree().create_timer(0.2).timeout
		
		_on_points_confetti( _randomized_points, _points_location.position )
		update_points_display.emit( _randomized_points )


func _on_points_confetti( points_amount : int , points_location : Vector2 ): 
	#print_debug( "_on_points_confetti: " + str( points_amount ) )
	
	#if %ConfettiMarkers:
	var new_points_confetti = POINTS_CONFETTI_SCENE.instantiate()
	new_points_confetti.position = points_location
	add_child(new_points_confetti)
	new_points_confetti.set_points_info( points_amount )
	
	pass
