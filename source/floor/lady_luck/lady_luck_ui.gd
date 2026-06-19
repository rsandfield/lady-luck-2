class_name LadyLuckUI
extends Control

signal finished

@onready var _images = %Images
@onready var _hand = %Hand
var _item_ui: ItemUI


func ready():
	hold_item(null)


func hold_item(item: ItemResource) -> void:
	for child in _hand.get_children():
		child.queue_free()

	if !item:
		return

	var ui_scene = item.ui_scene()
	if !ui_scene:
		return

	var item_ui = ui_scene.instantiate()
	item_ui.set_resource(item)
	_hand.add_child(item_ui)
	_item_ui = item_ui


func play_item(cell: GridCell) -> void:
	if !_item_ui:
		return

	await get_tree().create_timer(0.5).timeout
	var tween = create_tween()
	tween.tween_property(_item_ui, "global_position", cell.position(), 0.5)
	tween.finished.connect(finished.emit)
