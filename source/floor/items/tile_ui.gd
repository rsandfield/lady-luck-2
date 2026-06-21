class_name TileUI
extends ItemUI

const COLORS: Array[Color] = [Color(0, 0, 0, 0), Color.RED, Color.GREEN, Color.BLUE]

#var tile_type = "tile"    # tile or door

@onready var up := $Up
@onready var down := $Down
@onready var left := $Left
@onready var right := $Right

@onready var door_up := %DoorUp
@onready var door_down := %DoorDown
@onready var door_left := %DoorLeft
@onready var door_right := %DoorRight

@onready var side_ui: Array[ColorRect] = [up, right, down, left]
@onready var door_side_ui: Array[ColorRect] = [door_up, door_right, door_down, door_left]

@export var resource: TileResource


func set_resource(new_resource: TileResource) -> void:
	resource = new_resource
	if !resource:
		return

	if !is_node_ready():
		await ready

	var sides = resource.get_sides()
	for i in 4:
		side_ui[i].modulate = COLORS[sides[i]]
		door_side_ui[i].modulate = COLORS[sides[i]]
		
		# hide the colored sides if the object is not a door 
		if !resource.is_door: 
			door_side_ui[i].modulate = COLORS[0]


func set_visible_is_moving(is_moving: bool, modulate_color: Color) -> void:
	super(is_moving, modulate_color)
	Game.moving_tile_resource = resource

	up.visible = !is_moving
	down.visible = !is_moving
	left.visible = !is_moving
	right.visible = !is_moving
