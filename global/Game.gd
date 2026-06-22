extends Node

var debug_enabled = false

var moving_tile_resource
var grid_tile_hovered

var slot_machine_blocked_flag : bool = false
## Whether tiles check if neighbors have valid connections
var neighbor_validation : bool = true

var change_state_machine = ""
var change_lady_luck_expression = "" 
var make_lady_luck_spin = false
