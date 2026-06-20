class_name FloorConfig
extends Resource

@export var grid_size: Vector2i = Vector2i(5, 7)
@export var wheel_count: int = 4
@export var spinner_item_count: int = 6
@export var color_count: int = 1
@export var neighbor_validation: bool = false
@export var spinner_rewards: RewardConfig = RewardConfig.new()
@export var slot_rewards: RewardConfig = RewardConfig.new()