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


func spin(to: int) -> void:
	var clockwise = to >= 0
	var slice_count = len(_slices)
	@warning_ignore("INTEGER_DIVISION")
	var rotations = to / slice_count
	to = posmod(to, slice_count)

	var target_rotation = -_slices[to].rotation
	var delta := fmod(target_rotation - rotation, TAU)

	if clockwise:
		if delta > 0:
			delta -= TAU
	else:
		if delta < 0:
			delta += TAU

	var tween = create_tween()
	var windup := TAU / float(slice_count) * 0.25
	var extra_spins: float = TAU * rotations
	if clockwise:
		windup *= -1
		extra_spins *= -1

	var rot := rotation - windup
	tween.tween_property(self, "rotation", rot, 0.5)
	var high_speed = extra_spins - windup + delta
	if clockwise:
		high_speed = -absf(high_speed)
	else:
		high_speed = absf(high_speed)
	rot += high_speed
	tween.tween_property(self, "rotation", rot, abs(high_speed) * 0.1)
	if clockwise:
		rot -= TAU
	else:
		rot += TAU
	tween.tween_property(self, "rotation", rot, 0.5)
	tween.finished.connect(finished.emit)
