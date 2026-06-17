class_name MouseObject
extends Node2D

signal tile_released

@onready var tile_ui = $TileUI


func _ready() -> void:
	
	pass


func _process(_delta: float) -> void:
	
	# move the object with the mouse when it moves
	if visible: 
		position = get_viewport().get_mouse_position()
		
		# populate the tile if it is empty
		if tile_ui.resource == null:
			tile_ui.set_resource( Game.moving_tile_resource )
	
	# prepare the tile for the next resource
	if !visible && tile_ui.resource != null: 
		tile_ui.resource = null
		
		# drop the tile onto the grid when the mouse is released
		if Game.grid_tile_hovered != null: 
			tile_released.emit()
	
	pass
