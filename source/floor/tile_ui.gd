class_name TileUI
extends PanelContainer

const COLORS: Array[Color] = [
	Color(0, 0, 0, 0),
	Color.RED,
	Color.GREEN,
	Color.BLUE
]

const tile_color_show = Color(1.0, 1.0, 1.0, 1.0)
const tile_color_hide = Color(0.0, 0.0, 0.0, 0.0)

var tile_is_moving = false


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

func set_visible_is_moving( is_moving: bool, modulate_color: Color ) -> void:
	
	Game.moving_tile_resource = resource
	
	tile_is_moving = is_moving
	set_self_modulate( modulate_color ) 
	
	up.visible    = !is_moving 
	down.visible  = !is_moving
	left.visible  = !is_moving 
	right.visible = !is_moving
