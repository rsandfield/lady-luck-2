@tool
class_name PieSlice
extends Node2D

@export var line_color: Color = Color.BLACK
@export var fill_color: Color = Color.PURPLE
@export var denominator: int = 4
@export var line_width: float = 4
@export var radius: float = 100

# func _process(_delta: float):
# 	queue_redraw()


func _draw():
	var arc := TAU / denominator
	var edge = Vector2.UP * radius
	var points: PackedVector2Array = [Vector2.ZERO]
	var point_count: float = 16
	var offset = 0
	if denominator % 2 == 0:
		offset = point_count * 0.5
	for i in point_count + 1:
		points.append(edge.rotated((i - offset) * arc / point_count))
	points.append(Vector2.ZERO)

	draw_colored_polygon(points, fill_color)
	draw_polyline(points, line_color, line_width)
