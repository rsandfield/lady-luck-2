class_name SpinUI
extends ItemUI


@export var resource: SpinResource


func set_resource(new_resource: SpinResource) -> void:
	resource = new_resource
	if !resource:
		return

	if !is_node_ready():
		await ready

	%Spin.flip_h = !resource.clockwise


func set_visible_is_moving(is_moving: bool, modulate_color: Color) -> void:
	super(is_moving, modulate_color)
	Game.moving_tile_resource = resource
