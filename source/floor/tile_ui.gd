class_name TileUI
extends PanelContainer

const COLORS: Array[Color] = [
	Color(0, 0, 0, 0),
	Color.RED,
	Color.GREEN,
	Color.BLUE
]

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

	var sides = resource.get_sides()
	for i in 4:
		side_ui[i].modulate = COLORS[sides[i]]
