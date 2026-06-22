extends Control


var show_new_expression = "" 


func _ready() -> void:
	
	_show_face_smile()
	
	pass

func _process(_delta: float) -> void:
	
	if Game.change_lady_luck_expression != "": 
		
		show_new_expression = Game.change_lady_luck_expression
		Game.change_lady_luck_expression = "" 
		
		if show_new_expression == "ohh": _show_face_ohh()
		if show_new_expression == "wait": _show_face_wait()
		if show_new_expression == "kiss": _show_face_kiss()
		if show_new_expression == "smile": _show_face_smile()
		
		pass
	
	if Game.make_lady_luck_spin: 
		Game.make_lady_luck_spin = false
		show_spin_animation()
	
	pass

func show_spin_animation() -> void:
	print_debug("show_spin_animation...")
	
	$AnimationPlayer1.play("wheel_spin")
	
	pass


func _show_face_smile() -> void:
	#print_debug("_show_face_smile...")
	
	%Face_Wait.visible = false
	%Face_Kiss.visible = false
	%Face_Ooh.visible = false
	%Face_Smile.visible = true
	
	pass


func _show_face_ohh() -> void:
	#print_debug("_show_face_ohh...")
	
	%Face_Wait.visible = false
	%Face_Kiss.visible = false
	%Face_Ooh.visible = true
	%Face_Smile.visible = false
	
	pass


func _show_face_kiss() -> void:
	#print_debug("_show_face_kiss...")
	
	%Face_Wait.visible = false
	%Face_Kiss.visible = true
	%Face_Ooh.visible = false
	%Face_Smile.visible = false
	
	pass


func _show_face_wait() -> void:
	#print_debug("_show_face_wait...")
	
	%Face_Wait.visible = true
	%Face_Kiss.visible = false
	%Face_Ooh.visible = false
	%Face_Smile.visible = false
	
	pass
