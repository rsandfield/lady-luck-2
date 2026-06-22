extends Control


func _ready() -> void:
	
	_show_face_smile()
	
	pass


func _show_face_smile() -> void:
	print_debug("_show_face_smile...")
	
	%Face_Wait.visible = false
	%Face_Kiss.visible = false
	%Face_Ooh.visible = false
	%Face_Smile.visible = true
	
	pass


func _show_face_ohh() -> void:
	print_debug("_show_face_ohh...")
	
	%Face_Wait.visible = false
	%Face_Kiss.visible = false
	%Face_Ooh.visible = true
	%Face_Smile.visible = false
	
	pass


func _show_face_kiss() -> void:
	print_debug("_show_face_kiss...")
	
	%Face_Wait.visible = false
	%Face_Kiss.visible = true
	%Face_Ooh.visible = false
	%Face_Smile.visible = false
	
	pass


func _show_face_wait() -> void:
	print_debug("_show_face_wait...")
	
	%Face_Wait.visible = true
	%Face_Kiss.visible = false
	%Face_Ooh.visible = false
	%Face_Smile.visible = false
	
	pass
