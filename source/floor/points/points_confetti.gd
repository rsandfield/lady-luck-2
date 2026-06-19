extends CharacterBody2D


const GRAVITY = 200.0

var new_points : int = 0

var my_color_red : Color = Color(0.734, 0.235, 0.98, 1.0)
var my_color_green : Color = Color(0.948, 0.82, 0.24, 1.0)



func _ready() -> void:
	
	velocity.y = -150.0
	velocity.x = randf_range(-80.0,80.0)
	
	pass

func _physics_process(delta):
	
	velocity.y += delta * GRAVITY
	
	var motion = velocity * delta
	move_and_collide(motion)
	
	pass

func _set_points_info( points : int ): 
	print_debug("_set_points_color: " + str(points) )
	
	new_points = points
	$Label.text = str(new_points) 
	
	if new_points > 0: $Label.set("theme_override_colors/font_color", my_color_green)
	if new_points < 0: $Label.set("theme_override_colors/font_color", my_color_red)
	
	$AnimationPlayer.play("float")
	
	pass
