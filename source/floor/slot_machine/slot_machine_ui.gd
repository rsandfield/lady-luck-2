class_name SlotMachineUI
extends Node

signal spin_requested


const WheelUIScene = preload("./slot_wheel_ui.tscn")

var wheels: Array[SlotWheelUI] = []

func _ready():
	populate_wheels([])
	$Button.pressed.connect(spin_requested.emit)


func populate_wheels(new_wheels: Array[SlotWheel]) -> void:
	for child in get_children():
		if child is SlotWheelUI:
			child.queue_free()
	for wheel in new_wheels:
		var wheel_ui = WheelUIScene.instantiate()
		wheel.set_ui(wheel_ui)
		add_child(wheel_ui)
		move_child(wheel_ui, 0)
