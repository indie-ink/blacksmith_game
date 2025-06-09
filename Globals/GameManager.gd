extends Node

enum CraftingStage { ORE_ROCK, FURNACE, ANVIL, WATER_BARREL, WEAPON_RACK }

var _current_stage: CraftingStage = CraftingStage.ORE_ROCK

var _balance := 0
var _current_item_price := 20
var _price_deviation := 0.15

func _enter_tree() -> void:
	SignalHub.reset_stages_states.connect(handle_reset_stages_states)
	SignalHub.ore_stage_passed.connect(handle_ore_stage_passed)
	SignalHub.furnace_stage_passed.connect(handle_furnace_stage_passed)
	SignalHub.furnace_stage_failed.connect(handle_furnace_stage_failed)
	SignalHub.anvil_stage_passed.connect(handle_anvil_stage_passed)
	SignalHub.weapon_cooled.connect(handle_weapon_cooled)
	SignalHub.weapon_rack_stage_passed.connect(handle_weapon_rack_stage_passed)


func initial_setup() -> void:
	_balance = 0
	SignalHub.emit_balance_updated(_balance)
	set_current_stage(CraftingStage.WATER_BARREL)


#region change stages

func handle_reset_stages_states() -> void:
	set_current_stage(CraftingStage.ORE_ROCK)


func handle_ore_stage_passed() -> void:
	set_current_stage(CraftingStage.FURNACE)


func handle_furnace_stage_passed() -> void:
	set_current_stage(CraftingStage.ANVIL)


func handle_furnace_stage_failed() -> void:
	set_current_stage(CraftingStage.ORE_ROCK)


func handle_anvil_stage_passed() -> void:
	set_current_stage(CraftingStage.WATER_BARREL)


func handle_weapon_cooled() -> void:
	set_current_stage(CraftingStage.WEAPON_RACK)


func handle_weapon_rack_stage_passed() -> void:
	_balance += randf_range(
		_current_item_price - _current_item_price * _price_deviation,
		_current_item_price + _current_item_price * _price_deviation
	)
	SignalHub.emit_balance_updated(_balance)
	set_current_stage(CraftingStage.ORE_ROCK)
#endregion


#region utility
func get_current_stage() -> CraftingStage:
	return _current_stage


func set_current_stage(new_stage: CraftingStage) -> void:
	if !CraftingStage.values().has(new_stage): return

	_current_stage = new_stage
	SignalHub.emit_stage_updated(new_stage)


func is_stage_allowed(stage: CraftingStage) -> bool:
	return _current_stage == stage
#endregion
