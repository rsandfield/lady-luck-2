class_name GridCellUI
extends PanelContainer

signal pressed

@onready var _tile_ui: TileUI = $TileUI
@onready var _door_icon: Control = $Door

func _ready():
	$Button.pressed.connect(pressed.emit)


func set_tile(tile: TileResource) -> void:
	_tile_ui.set_resource(tile)
	_tile_ui.visible = tile != null
	_door_icon.visible = tile && tile.is_door
