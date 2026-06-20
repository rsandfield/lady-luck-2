class_name MouseObject
extends Node2D

signal tile_released

@onready var _default_tile_ui = $TileUI
@onready var _valid = $Valid
@onready var _invalid = $Invalid
var _item_ui


const EXPLOSION_REFERENCE = preload("res://source/animations/explosion.tscn")
#const explosion_reference = preload("res://source/animations/explosion.tscn")
#Game.moving_tile_resource


func _ready():
	_default_tile_ui.visible = false
	if _valid is Control:
		_valid.mouse_filter = Control.MOUSE_FILTER_IGNORE
	if _invalid is Control:
		_invalid.mouse_filter = Control.MOUSE_FILTER_IGNORE


func _process(_delta: float) -> void:

	# move the object with the mouse when it moves
	if visible:
		position = get_viewport().get_mouse_position()

		var cell = Game.grid_tile_hovered
		var item = Game.moving_tile_resource
		if cell != null && item != null:
			var legal = cell.is_legal_play(item)
			_valid.visible = legal
			_invalid.visible = !legal
		else:
			_valid.visible = false
			_invalid.visible = false

		# populate the tile if it is empty
		if !_item_ui and Game.moving_tile_resource:
			_default_tile_ui.visible = false
			_item_ui = Game.moving_tile_resource.ui_scene().instantiate()
			if _item_ui.has_method("set_resource"):
				_item_ui.set_resource( Game.moving_tile_resource )
			_item_ui.mouse_filter = Control.MOUSE_FILTER_IGNORE
			add_child(_item_ui)

	# prepare the tile for the next resource
	if !visible && _item_ui:
		_valid.visible = false
		_invalid.visible = false
		_item_ui.queue_free()
		_item_ui = null

		# drop the tile onto the grid when the mouse is released
		if Game.grid_tile_hovered != null:
			tile_released.emit()

			#print_debug( type_string( typeof( Game.moving_tile_resource ) ) )
			#print_debug( Game.moving_tile_resource.get_class() )

			print_debug( Game.moving_tile_resource.get_script() )
			print_debug( Game.moving_tile_resource.get_script() == load( "res://source/floor/items/bomb_resource.gd" ) )

			#(res://source/floor/items/bomb_resource.gd):<GDScript#-9223371984207870383>
			#(res://source/floor/items/tile_resource.gd):<GDScript#-9223371987865303497>

			if Game.moving_tile_resource.get_script() == load( "res://source/floor/items/bomb_resource.gd" ):

				#testing...
				var new_explosion = EXPLOSION_REFERENCE.instantiate()
				get_parent().add_child( new_explosion )
				new_explosion.position = position
				new_explosion._on_call_explode()
