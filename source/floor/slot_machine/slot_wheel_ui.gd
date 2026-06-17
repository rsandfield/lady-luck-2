class_name SlotWheelUI
extends Control

signal pressed
signal moving_tile( is_clicked : bool )

@onready var _spinner: Control = $Spinner
var _tiles: Array[SlotTileUI] = []
var _top_index = 0

func _ready():
	$Button.pressed.connect(pressed.emit)
	for child in _spinner.get_children():
		child.queue_free()


func populate(tile: TileResource):
	# Ensure the visual initializes cleanly
	while len(_tiles) < 3:
		_add_tile_ui(tile)

	var tile_ui = _tiles[1].tile_ui
	tile_ui.set_resource(tile)
	tile_ui.visible = tile != null


func _on_button_button_down() -> void:
	pressed.emit()
	if len(_tiles) < 2:
		return

	var tile_ui = _tiles[1].tile_ui
	tile_ui.tile_is_moving = true
	tile_ui.set_visible_is_moving( tile_ui.tile_is_moving, tile_ui.tile_color_hide)
	
	moving_tile.emit(true)


func _on_button_button_up() -> void:
	if len(_tiles) < 2:
		return

	var tile_ui = _tiles[1].tile_ui
	tile_ui.tile_is_moving = false
	tile_ui.set_visible_is_moving( tile_ui.tile_is_moving, tile_ui.tile_color_show)
	
	moving_tile.emit(false)


func spin(new_tiles: Array[TileResource]) -> void:
	_prune_old_tiles()
	_populate_tiles(new_tiles)
	
	await _spin_up()
	for i in range(len(_tiles) + 4):
		await _spin_down()


func _spin_up():
	var old_bottom = posmod(_top_index - 1, len(_tiles))
	_top_index = old_bottom
	_tiles[_top_index].position.y = -112.5
	for tile in _tiles:
		tile.spin_up(0.5)
	await _tiles[-1].finished


func _spin_down():
	var old_top = _top_index
	_top_index = (old_top + 1) % len(_tiles)
	_tiles[old_top].position.y = -37.5 + 75.0 * len(_tiles)
	for tile in _tiles:
		tile.spin_down()
	await _tiles[-1].finished


func _prune_old_tiles():
	if len(_tiles) < 3:
		return

	for tile in _tiles.slice(3):
		tile.queue_free()
	_tiles = _tiles.slice(0, 3)
	_top_index = 0


func _populate_tiles(tiles: Array[TileResource]) -> void:
	for tile in tiles:
		_add_tile_ui(tile)
	
	if len(_tiles) < 3:
		return
	# Move the old tiles to the end
	var front = _tiles.slice(0, 3)
	_tiles = _tiles.slice(3)
	_tiles.append_array(front)
	_top_index = len(_tiles) - 3


func _add_tile_ui(tile: TileResource) -> void:
	var slot_ui = SlotTileUI.new()
	_spinner.add_child(slot_ui)
	_tiles.append(slot_ui)

	slot_ui.position = Vector2(0, -112.5 + 75 * len(_tiles))

	var tile_ui = tile.ui_scene().instantiate() as TileUI
	tile_ui.set_resource(tile)
	slot_ui.tile_ui = tile_ui
	slot_ui.add_child(tile_ui)
	tile_ui.position = Vector2(10, 0)
