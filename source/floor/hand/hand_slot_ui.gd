class_name HandSlotUI
extends Control

signal pressed
signal hovered(is_hovered: bool)
signal moving_tile(is_clicked: bool)

@onready var _hover_indicator: TextureRect = $HoverIndicator

var _item_ui: ItemUI
var is_active_tile: bool = false


func _ready():
	%Button.pressed.connect(pressed.emit)
	%Button.button_down.connect(_on_button_button_down)
	%Button.button_up.connect(_on_button_button_up)
	_hover_indicator.visible = false
	%TileUI.visible = false


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


func set_tile(tile: ItemResource) -> void:
	# Remove previous item UI
	if _item_ui:
		remove_child(_item_ui)
		_item_ui.queue_free()
		_item_ui = null

	if !tile:
		return

	_item_ui = tile.ui_scene().instantiate()
	if _item_ui.has_method("set_resource"):
		_item_ui.set_resource(tile)
	_item_ui.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(_item_ui)


func _on_button_button_down() -> void:
	if !_item_ui:
		return
	_item_ui.tile_is_moving = true
	_item_ui.set_visible_is_moving(_item_ui.tile_is_moving, _item_ui.TILE_COLOR_HIDE)
	moving_tile.emit(true)


func _on_button_button_up() -> void:
	if !_item_ui:
		return
	_item_ui.tile_is_moving = false
	_item_ui.set_visible_is_moving(_item_ui.tile_is_moving, _item_ui.TILE_COLOR_SHOW)
	moving_tile.emit(false)
