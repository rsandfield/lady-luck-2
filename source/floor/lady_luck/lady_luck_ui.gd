class_name LadyLuckUI
extends Control

signal finished

#@onready var _images = %Images
@onready var _hand = %Hand
var _item_ui: ItemUI


func ready():
	hold_item(null)


func hold_item(item: ItemResource) -> void:
	#print_debug("hold_item: " + str(item) )
	
	if _item_ui:
		_item_ui.queue_free()

	if !item:
		return

	var ui_scene = item.ui_scene()
	if !ui_scene:
		return

	var item_ui = ui_scene.instantiate()
	if item_ui.has_method("set_resource"):
		item_ui.set_resource(item)
	get_parent().add_child(item_ui)
	item_ui.top_level = true
	item_ui.z_index = 100
	item_ui.global_position = _hand.global_position
	_item_ui = item_ui


func play_item(cell: GridCell) -> void:
	if !_item_ui:
		return

	await get_tree().create_timer(0.5).timeout
	if !is_inside_tree() or !is_instance_valid(_item_ui):
		return

	var tween = create_tween()
	tween.bind_node(self)
	tween.tween_property(_item_ui, "global_position", cell.position() - cell.size() / 2, 0.5)
	tween.finished.connect(_item_ui.queue_free)
	tween.finished.connect(finished.emit)
