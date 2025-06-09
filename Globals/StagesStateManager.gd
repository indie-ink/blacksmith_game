extends Node

enum CraftingItemsType { SWORD, AXE, SPEAR }

const ITEMS_TO_CRAFT: Dictionary[CraftingItemsType, Dictionary] = {
	CraftingItemsType.SWORD: {
		"display_name": "Sword",
		"price": 20,
		"recipe": {
			"ore_required": 2,
			"heat_time_required": 4.0,
			"max_overheat_time": 2.0,
			"hits_required": 4,
			"max_hits_missed": 3
		}
	},
	CraftingItemsType.AXE: {
		"display_name": "Axe",
		"price": 30,
		"recipe": {
			"ore_required": 3,
			"heat_time_required": 5.0,
			"max_overheat_time": 2.0,
			"hits_required": 5,
			"max_hits_missed": 3
		}
	},
	CraftingItemsType.SPEAR: {
		"display_name": "Spear",
		"price": 40,
		"recipe": {
			"ore_required": 4,
			"heat_time_required": 6.0,
			"max_overheat_time": 2.0,
			"hits_required": 8,
			"max_hits_missed": 4
		}
	},
}


var _selected_item_to_craft: Dictionary = ITEMS_TO_CRAFT[CraftingItemsType.SWORD]
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
	"hits_missed": 0,
	"hits_required": 4,
	"max_hits_missed": 3
}


func _enter_tree() -> void:
	SignalHub.select_item_to_craft.connect(handle_select_item_to_craft)
	SignalHub.ore_collected.connect(handle_ore_collected)
	SignalHub.furnace_heat_updated.connect(handle_furnace_heat_updated)
	SignalHub.anvil_hit_reached.connect(handle_anvil_hit_reached)
	SignalHub.anvil_hit_missed.connect(handle_anvil_hit_missed)
	SignalHub.reset_stages_states.connect(handle_reset_stages_states)


func initial_setup() -> void:
	set_item_to_craft(CraftingItemsType.SWORD)


func get_selected_item_to_craft_price() -> float:
	return _selected_item_to_craft["price"]


func handle_select_item_to_craft(item_type: CraftingItemsType) -> void:
	set_item_to_craft(item_type)


func handle_ore_collected() -> void:
	_ore_stage_state["ore_collected"] = clamp(
		_ore_stage_state["ore_collected"] + 1,
		0,
		_ore_stage_state["ore_required"]
	)
	emit_ore_stage_update()


func handle_furnace_heat_updated(heat_time: float, overheat_time: float) -> void:
	_furnace_stage_state["current_heat_time"] = heat_time
	_furnace_stage_state["current_overheat_time"] = overheat_time

	emit_furnace_stage_update()


func handle_anvil_hit_reached() -> void:
	_anvil_stage_state["hits_reached"] = clamp(
		_anvil_stage_state["hits_reached"] + 1,
		0,
		_anvil_stage_state["hits_required"]
	)
	emit_anvil_stage_update()


func handle_anvil_hit_missed() -> void:
	_anvil_stage_state["hits_missed"] = clamp(
		_anvil_stage_state["hits_missed"] + 1,
		0,
		_anvil_stage_state["max_hits_missed"]
	)
	emit_anvil_stage_update()


func handle_reset_stages_states() -> void:
	reset_ore_stage_state()
	reset_furnace_stage_state()
	reset_anvil_stage_state()


#region utilities
func set_item_to_craft(weapon_type: CraftingItemsType) -> void:
	_selected_item_to_craft = ITEMS_TO_CRAFT[weapon_type]
	SignalHub.emit_item_to_craft_selected(_selected_item_to_craft)
	SignalHub.emit_reset_stages_states()


func reset_ore_stage_state() -> void:
	_ore_stage_state["ore_required"] = _selected_item_to_craft["recipe"]["ore_required"]
	_ore_stage_state["ore_collected"] = 0
	emit_ore_stage_update()


func reset_furnace_stage_state() -> void:
	_furnace_stage_state["heat_time_required"] = _selected_item_to_craft["recipe"]["heat_time_required"]
	_furnace_stage_state["max_overheat_time"] = _selected_item_to_craft["recipe"]["max_overheat_time"]
	_furnace_stage_state["current_heat_time"] = 0.0
	_furnace_stage_state["current_overheat_time"] = 2.0
	emit_furnace_stage_update()


func reset_anvil_stage_state() -> void:
	_anvil_stage_state["hits_required"] = _selected_item_to_craft["recipe"]["hits_required"]
	_anvil_stage_state["max_hits_missed"] = _selected_item_to_craft["recipe"]["max_hits_missed"]
	_anvil_stage_state["hits_reached"] = 0
	_anvil_stage_state["hits_missed"] = 0
	emit_anvil_stage_update()


func emit_ore_stage_update() -> void:
	SignalHub.emit_ore_stage_state_updated(
		_ore_stage_state["ore_collected"],
		_ore_stage_state["ore_required"]
	)


func emit_furnace_stage_update() -> void:
	SignalHub.emit_furnace_stage_state_updated(
		_furnace_stage_state["current_heat_time"],
		_furnace_stage_state["current_overheat_time"],
		_furnace_stage_state["heat_time_required"],
		_furnace_stage_state["max_overheat_time"]
	)


func emit_anvil_stage_update() -> void:
	SignalHub.emit_anvil_stage_state_updated(
		_anvil_stage_state["hits_reached"],
		_anvil_stage_state["hits_missed"],
		_anvil_stage_state["hits_required"],
		_anvil_stage_state["max_hits_missed"]
	)

#endregion
