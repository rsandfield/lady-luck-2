class_name TileUI
extends ItemUI

const COLORS: Array[Color] = [Color(0, 0, 0, 0), Color.RED, Color.GREEN, Color.BLUE]

@onready var left := $Left
@onready var right := $Right
@onready var up := $Up
@onready var down := $Down

@onready var side_ui: Array[ColorRect] = [up, right, down, left]
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


func set_visible_is_moving(is_moving: bool, modulate_color: Color) -> void:
	super(is_moving, modulate_color)
	Game.moving_tile_resource = resource

	up.visible = !is_moving
	down.visible = !is_moving
	left.visible = !is_moving
	right.visible = !is_moving
