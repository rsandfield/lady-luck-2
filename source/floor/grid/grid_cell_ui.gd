class_name GridCellUI
extends PanelContainer

signal pressed
signal hovered(is_hovered: bool)

@onready var _tile_ui: TileUI = $TileUI
@onready var _door_icon: Control = $Door
@onready var _hover_indicator: TextureRect = $HoverIndicator

var is_active_tile = false


func _ready():
	%Button.pressed.connect(pressed.emit)
	_hover_indicator.visible = false


func _process(_delta: float) -> void:
	var is_hovered = %Button.get_global_rect().has_point(get_global_mouse_position())

	if is_hovered && !is_active_tile:
		is_active_tile = true
		_hover_indicator.visible = true
		hovered.emit(true)

	if !is_hovered && is_active_tile:
		is_active_tile = false
		_hover_indicator.visible = false
		hovered.emit(false)


func set_resource(tile: TileResource) -> void:
	_tile_ui.set_resource(tile)
	_tile_ui.visible = tile != null
	_tile_ui.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_door_icon.visible = tile && tile.is_door
