class_name SlotWheelUI
extends Control

signal pressed

@onready var tile_ui: TileUI = $TileUI

func _ready():
	$Button.pressed.connect(pressed.emit)

func populate(tile: TileResource):
	tile_ui.set_resource(tile)
	tile_ui.visible = tile != null
