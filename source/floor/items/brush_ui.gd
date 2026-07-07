class_name BrushUI
extends ItemUI


@export var resource: BrushResource


func set_resource(new_resource: BrushResource) -> void:
	resource = new_resource
	if !resource:
		return

	if !is_node_ready():
		await ready

	match resource.color:
		1:
			%Red.visible = true
		2:
			%Green.visible = true
		3:
			%Blue.visible = true


func set_visible_is_moving(is_moving: bool, modulate_color: Color) -> void:
	super(is_moving, modulate_color)
	Game.moving_tile_resource = resource
