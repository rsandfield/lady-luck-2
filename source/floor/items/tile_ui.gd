class_name TileUI
extends ItemUI

const COLORS: Array[Color] = [
	Color(0, 0, 0, 0),
	Color(1.0, 0.461, 0.393, 1.0),
	Color(0.0, 0.999, 0.0, 1.0),
	Color(0.353, 0.553, 1.0, 1.0)
	]

@onready var door_up := %DoorUp
@onready var door_down := %DoorDown
@onready var door_left := %DoorLeft
@onready var door_right := %DoorRight

@onready var elbow_ne := %ElbowNE
@onready var elbow_se := %ElbowSE
@onready var elbow_sw := %ElbowSW
@onready var elbow_nw := %ElbowNW

@onready var horizontal := %Horizontal
@onready var vertical := %Vertical

@onready var door_side_ui: Array[TextureRect] = [door_up, door_right, door_down, door_left]
# Each entry: [side_a_index, side_b_index, elbow_node]
@onready var elbow_pairs := [
	[0, 1, elbow_ne],
	[1, 2, elbow_se],
	[2, 3, elbow_sw],
	[3, 0, elbow_nw],
]

@export var resource: TileResource


func set_resource(new_resource: TileResource) -> void:
	resource = new_resource
	if !resource:
		return

	if !is_node_ready():
		await ready

	var sides = resource.get_sides()
	for i in 4:
		door_side_ui[i].modulate = COLORS[sides[i]]

	# Show elbow when two adjacent sides share the same non-empty color
	for pair in elbow_pairs:
		var a: int = pair[0]
		var b: int = pair[1]
		var elbow: TextureRect = pair[2]
		if sides[a] != 0 and sides[a] == sides[b]:
			elbow.modulate = COLORS[sides[a]]
			door_side_ui[a].modulate = COLORS[0]
			door_side_ui[b].modulate = COLORS[0]
		else:
			elbow.modulate = COLORS[0]

	# Show straight when two opposite sides share the same non-empty color
	# Horizontal: east (1) + west (3), Vertical: north (0) + south (2)
	if sides[1] != 0 and sides[1] == sides[3]:
		horizontal.modulate = COLORS[sides[1]]
		door_side_ui[1].modulate = COLORS[0]
		door_side_ui[3].modulate = COLORS[0]
	else:
		horizontal.modulate = COLORS[0]

	if sides[0] != 0 and sides[0] == sides[2]:
		vertical.modulate = COLORS[sides[0]]
		door_side_ui[0].modulate = COLORS[0]
		door_side_ui[2].modulate = COLORS[0]
	else:
		vertical.modulate = COLORS[0]


func set_visible_is_moving(is_moving: bool, modulate_color: Color) -> void:
	super(is_moving, modulate_color)
	Game.moving_tile_resource = resource
