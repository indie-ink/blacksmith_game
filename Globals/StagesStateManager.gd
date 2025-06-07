extends Node

var _ore_stage_state: Dictionary[String, Variant] = {
	"ore_required": 3,
	"ore_collected": 0,
}
var _furnace_stage_state: Dictionary[String, Variant] = {
	"heat_time_required": 4.0,
	"max_overheat_time": 2.0,
	"current_heat_time": 0.0,
	"current_overheat_time": 0.0,
}
var _anvil_stage_state: Dictionary[String, Variant] = {
	"hits_reached": 0,
	"hits_missed": 0
}


func _enter_tree() -> void:
	SignalHub.ore_collected.connect(handle_ore_collected)


func handle_ore_collected() -> void:
	_ore_stage_state["ore_collected"] = clamp(
		_ore_stage_state["ore_collected"] + 1,
		0,
		_ore_stage_state["ore_required"]
	)
	SignalHub.emit_ore_stage_state_updated(
		_ore_stage_state["ore_collected"],
		_ore_stage_state["ore_required"]
	)
