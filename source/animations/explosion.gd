class_name Explosion
extends Node2D


func _on_call_reset() -> void:
	$AnimationPlayer.play("RESET")


func play_explosion() -> void:
	$AnimationPlayer.play("explode")
	$AnimationPlayer.animation_finished.connect(queue_free)


func play_explosion_test() -> void:
	$AnimationPlayer.play("explode_test")

