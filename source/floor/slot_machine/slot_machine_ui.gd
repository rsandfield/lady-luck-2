class_name SlotMachineUI
extends Node

signal spin_requested
signal spin_sound_play
signal moving_tile(is_clicked: bool)

const WheelUIScene = preload("./slot_wheel_ui.tscn")

var wheels: Array[SlotWheelUI] = []


func _ready():
	populate_wheels([])
	$Button.pressed.connect(spin_requested.emit)
	$Button.pressed.connect(spin_sound_play.emit)


func populate_wheels(new_wheels: Array[SlotWheel]) -> void:
	for child in get_children():
		if child is SlotWheelUI:
			child.queue_free()
	for wheel in new_wheels:
		var wheel_ui = WheelUIScene.instantiate()

		#wheel_ui.moving_tile.connect(moving_tile.emit)
		wheel_ui.moving_tile.connect(_on_slot_cell_moving_tile)

		wheel.set_ui(wheel_ui)
		add_child(wheel_ui)
		move_child(wheel_ui, 0)


func _on_slot_cell_moving_tile(is_moving: bool) -> void:
	#print_debug( "_on_slot_cell_moving_tile: ")
	#print_debug( "here? : ")

	moving_tile.emit(is_moving)


func pull_lever() -> void:
	$AnimationPlayer.play("lever_pull")


func shake_lever() -> void:
	$AnimationPlayer.play("lever_shake")
