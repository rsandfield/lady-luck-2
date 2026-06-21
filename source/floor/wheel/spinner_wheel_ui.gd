@tool
class_name SpinnerWheelUI
extends Control

signal finished

@export var radius := 100.0
@export var line_width := 2.0

var _slices: Array[PieSlice] = []


func _ready():
	if Engine.is_editor_hint():
		make_pie([Color.RED, Color.GREEN, Color.BLUE])


func make_pie(slices: Array[Color]) -> void:
	for slice in _slices:
		slice.queue_free()
	_slices = []

	var count = len(slices)
	var i = 0
	for color in slices:
		var slice = PieSlice.new()
		slice.fill_color = color
		slice.denominator = count
		slice.radius = radius
		slice.position = size / 2
		slice.line_width = line_width
		add_child(slice)
		move_child(slice, 0)
		_slices.append(slice)

		slice.rotate(i * TAU / float(count))
		i += 1


func spin(to: int, extra_rotations: int = 3, clockwise: bool = true) -> void:
	var slice_count = len(_slices)
	to = posmod(to, slice_count)

	# Where the wheel must end so slice 'to' is centered at UP
	var destination = -_slices[to].rotation
	# Shortest angular step from current rotation to destination
	var delta := fposmod(destination - rotation, TAU)
	# Go the right direction, adding extra full rotations for visual flair
	var total_spin: float
	if clockwise:
		if delta > 0:
			delta -= TAU
		total_spin = delta - TAU * extra_rotations
	else:
		total_spin = delta + TAU * extra_rotations

	# 3-phase tween: windup (pull back), main spin, slowdown (one last rotation)
	var tween = create_tween()
	tween.bind_node(self)

	var windup_amount := TAU / float(slice_count) * 0.25
	var windup_dir := 1.0 if clockwise else -1.0

	var rot := rotation + windup_dir * windup_amount
	tween.tween_property(self, "rotation", rot, 0.5)

	rot += total_spin - windup_dir * windup_amount
	tween.tween_property(self, "rotation", rot, absf(total_spin) * 0.1)

	var slowdown := -TAU if clockwise else TAU
	rot += slowdown
	tween.tween_property(self, "rotation", rot, 0.5)

	tween.finished.connect(finished.emit)
