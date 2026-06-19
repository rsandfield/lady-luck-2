class_name SlotWheelUI
extends Control

signal pressed
signal moving_tile(is_clicked: bool)

const CENTER_Y := 37.5

@export var windup_speed := 0.3
@export var windup_time := 0.25
@export var cruise_speed := 7.0
@export var slow_speed := 5.0
@export var slower_speed := 3.0
@export var final_speed := 1.0
@export var decel_time := 0.25

@onready var _anim: AnimationPlayer = $AnimationPlayer
@onready
var _slots: Array[Control] = [$Spinner/Slot1, $Spinner/Slot2, $Spinner/Slot3, $Spinner/Slot4]

var _items: Array[ItemResource]
var _item_index: int = 0
var _spinning: bool = false
var _done_loading: bool = false
var _center_slot_idx: int = 1


func _ready():
	$Button.pressed.connect(pressed.emit)


func populate(item: ItemResource):
	for i in 4:
		_set_slot_item(i, item)


func clear_center():
	_set_slot_item(_center_slot_idx, null)


func spin(items: Array[ItemResource]):
	while len(items) % 4 != 0:
		items.insert(0, TileResource.random_two_side())

	_items = items
	_item_index = 0
	_done_loading = false
	_spinning = true

	_anim.speed_scale = windup_speed
	_anim.play("cycle")
	var speed_tween = create_tween()
	speed_tween.tween_property(_anim, "speed_scale", cruise_speed, windup_time).set_ease(
		Tween.EASE_IN
	)

	while _spinning:
		await get_tree().process_frame

	_anim.stop()


func _on_slot_swap(slot_idx: int) -> void:
	if !_spinning:
		return
	if _item_index < len(_items):
		_set_slot_item(slot_idx, _items[_item_index])
		_item_index += 1
		_update_speed()
	elif !_done_loading:
		_done_loading = true


func _process(_delta):
	if !_spinning or !_done_loading:
		return
	var center_y = _slots[_center_slot_idx].position.y
	if abs(center_y - CENTER_Y) < 3.0:
		_spinning = false


func _update_speed():
	var remaining = len(_items) - _item_index
	if remaining > 8:
		return
	var target_speed: float
	if remaining > 4:
		target_speed = slow_speed
	elif remaining > 2:
		target_speed = slower_speed
	else:
		target_speed = final_speed
	var tween = create_tween()
	tween.tween_property(_anim, "speed_scale", target_speed, decel_time).set_ease(Tween.EASE_OUT)


func _get_active_item_ui():
	var slot = _slots[_center_slot_idx]
	if slot.get_child_count() == 0:
		return null
	return slot.get_child(0)


func _on_button_button_down() -> void:
	pressed.emit()
	if _spinning:
		return
	var item_ui = _get_active_item_ui()
	if !item_ui:
		return
	item_ui.tile_is_moving = true
	item_ui.set_visible_is_moving(item_ui.tile_is_moving, item_ui.TILE_COLOR_HIDE)
	moving_tile.emit(true)


func _on_button_button_up() -> void:
	if _spinning:
		return
	var item_ui = _get_active_item_ui()
	if !item_ui:
		return
	item_ui.tile_is_moving = false
	item_ui.set_visible_is_moving(item_ui.tile_is_moving, item_ui.TILE_COLOR_SHOW)
	moving_tile.emit(false)


func _set_slot_item(slot_idx: int, item: ItemResource):
	var slot = _slots[slot_idx]
	for child in slot.get_children():
		slot.remove_child(child)
		child.queue_free()
	if !item:
		return
	var ui = item.ui_scene().instantiate()
	ui.set_resource(item)
	slot.add_child(ui)
