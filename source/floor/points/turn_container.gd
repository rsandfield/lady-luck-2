class_name TurnContainer
extends Control


var _points_boxes: Array[PointsBox]

var _value = 0


func _ready():
	_points_boxes = []
	for child in $PointsDisplay.get_children():
		if child is PointsBox:
			_points_boxes.append(child)


func add_value(delta: int) -> void:
	set_value(_value + delta)


func set_value(new_value: int) -> void:
	_value = new_value
	_on_parse_points()


func _on_parse_points():
	if _value < 0:
		for box in _points_boxes:
			box.set_number(0)
		return
		
	if _value > 999999: _value = 999999

	var points = _value
	for i in len(_points_boxes):
		var box = _points_boxes[len(_points_boxes) - i - 1]
		box.set_number(points % 10)
		points /= 10
