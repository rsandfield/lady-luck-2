class_name GridCellUI
extends PanelContainer

signal pressed

@onready var _tile_ui: TileUI = $TileUI
@onready var _door_icon: Control = $Door

var is_active_tile = false

func _ready():
	$Button.pressed.connect(pressed.emit)


func _process(_delta: float) -> void:
	
	var hovered = get_global_rect().has_point(get_global_mouse_position())

	# switch the active time and save the data in the game file
	if hovered && !is_active_tile:
		is_active_tile = true
		Game.grid_tile_hovered = self

	# clear the game information of the hovered object
	if !hovered && is_active_tile:
		is_active_tile = false
		Game.grid_tile_hovered = null

func set_tile(tile: TileResource) -> void:
	_tile_ui.set_resource(tile)
	_tile_ui.visible = tile != null
	_tile_ui.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_door_icon.visible = tile && tile.is_door
