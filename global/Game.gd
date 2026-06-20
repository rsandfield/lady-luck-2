extends Node

var debug_enabled = false

var moving_tile_resource
var grid_tile_hovered

var slot_machine_blocked_flag : bool = false
## Whether tiles check if neighbors have valid connections
var neighbor_validation : bool = true
#var slot_machine_give_points : bool = false

#var global_confetti_points = 0
