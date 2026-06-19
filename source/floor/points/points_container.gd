class_name PointsContainer
extends Control

const POINTS_CONFETTI_SCENE = preload("res://source/floor/points/points_confetti.tscn")

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


func _on_change_points(new_points: int) -> void:
	#print_debug( "_on_change_points: " + str( extra_arg_0 ) )

	var rand = randi_range(1, 49)

	_value += new_points - rand

	_on_parse_points()

	# print_debug( "_value: " + str( _value ) )

	if $Marker2d:
		var new_points_confetti = POINTS_CONFETTI_SCENE.instantiate()
		new_points_confetti.position = $Marker2D.position
		add_child(new_points_confetti)
		new_points_confetti.set_points_info(new_points - rand)


func _on_parse_points():
	if _value < 0:
		for box in _points_boxes:
			box.set_number(0)
		return

	var points = _value
	for i in len(_points_boxes):
		var box = _points_boxes[len(_points_boxes) - i - 1]
		box.set_number(points % 10)
		points /= 10
