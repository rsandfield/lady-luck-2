extends Control

@export var button_1_text : String
@export var button_2_text : String
@export var button_3_text : String

@export var show_tutorial : bool = true

signal button_menu
signal button_retry
signal button_help


func _ready() -> void:
	
	%LabelButton1.text = button_1_text
	%LabelButton2.text = button_2_text 
	%LabelButton3.text = button_3_text
	
	%ButtonTutorial.visible = show_tutorial
	%LabelButton3.visible = show_tutorial
	
	pass


func _on_button_menu_pressed() -> void:
	#print_debug("_on_button_menu_pressed...")
	
	button_menu.emit()
	
	pass


func _on_button_retry_pressed() -> void:
	#print_debug("_on_button_retry_pressed...")
	
	button_retry.emit()
	
	pass


func _on_button_tutorial_pressed() -> void:
	#print_debug("_on_button_tutorial_pressed...")
	
	button_help.emit()
	
	pass
