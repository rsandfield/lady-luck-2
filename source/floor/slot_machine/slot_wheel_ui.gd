class_name SlotWheelUI
extends Control

signal pressed
signal moving_tile( is_clicked : bool )

@onready var tile_ui: TileUI = $TileUI

func _ready():
	$Button.pressed.connect(pressed.emit)

func populate(tile: TileResource):
	tile_ui.set_resource(tile)
	tile_ui.visible = tile != null


func _on_button_button_down() -> void:
	
	emit_signal("pressed")
	
	tile_ui.tile_is_moving = true
	tile_ui.set_visible_is_moving( tile_ui.tile_is_moving, tile_ui.tile_color_hide)
	
	moving_tile.emit(true)
	
	pass


func _on_button_button_up() -> void:
	
	tile_ui.tile_is_moving = false
	tile_ui.set_visible_is_moving( tile_ui.tile_is_moving, tile_ui.tile_color_show)
	
	moving_tile.emit(false)
	
	pass
