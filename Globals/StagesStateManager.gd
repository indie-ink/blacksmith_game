extends Node

var _ore_stage_state: Dictionary[String, Variant] = {
	"ore_required": 3,
	"ore_collected": 0,
}
var _furnace_stage_state: Dictionary[String, Variant] = {
	"current_heat_time": 0.0,
	"current_overheat_time": 2.0,
	"heat_time_required": 4.0,
	"max_overheat_time": 2.0,
}
var _anvil_stage_state: Dictionary[String, Variant] = {
	"hits_reached": 0,
	"hits_missed": 0
}


func _enter_tree() -> void:
	SignalHub.ore_collected.connect(handle_ore_collected)
	SignalHub.furnace_heat_updated.connect(handle_furnace_heat_updated)
	SignalHub.weapon_sold.connect(handle_weapon_sold)


func initial_setup() -> void:
	SignalHub.emit_ore_stage_state_updated(
		_ore_stage_state["ore_collected"],
		_ore_stage_state["ore_required"]
	)
	SignalHub.emit_furnace_stage_state_updated(
		_furnace_stage_state["current_heat_time"],
		_furnace_stage_state["current_overheat_time"],
		_furnace_stage_state["heat_time_required"],
		_furnace_stage_state["max_overheat_time"]
	)


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

func handle_furnace_heat_updated(heat_time: float, overheat_time: float) -> void:
	_furnace_stage_state["current_heat_time"] = heat_time
	_furnace_stage_state["current_overheat_time"] = overheat_time

	SignalHub.emit_furnace_stage_state_updated(
		_furnace_stage_state["current_heat_time"],
		_furnace_stage_state["current_overheat_time"],
		_furnace_stage_state["heat_time_required"],
		_furnace_stage_state["max_overheat_time"]
	)


func handle_weapon_sold() -> void:
	_ore_stage_state["ore_collected"] = 0
	SignalHub.emit_ore_stage_state_updated(
		_ore_stage_state["ore_collected"],
		_ore_stage_state["ore_required"]
	)

	_furnace_stage_state["current_heat_time"] = 0.0
	_furnace_stage_state["current_overheat_time"] = 2.0
	SignalHub.emit_furnace_stage_state_updated(
		_furnace_stage_state["current_heat_time"],
		_furnace_stage_state["current_overheat_time"],
		_furnace_stage_state["heat_time_required"],
		_furnace_stage_state["max_overheat_time"]
	)