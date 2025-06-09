extends Node

enum CraftingStage { ORE_ROCK, FURNACE, ANVIL, WATER_BARREL, WEAPON_RACK }

var _current_stage: CraftingStage = CraftingStage.ORE_ROCK


func _enter_tree() -> void:
	SignalHub.reset_stages_states.connect(reset_to_initial_stage)

	SignalHub.ore_stage_passed.connect(proceed_to_next_stage)
	SignalHub.furnace_stage_passed.connect(proceed_to_next_stage)
	SignalHub.anvil_stage_passed.connect(proceed_to_next_stage)
	SignalHub.water_barrel_stage_passed.connect(proceed_to_next_stage)
	SignalHub.weapon_rack_stage_passed.connect(reset_to_initial_stage)


func initial_setup() -> void:
	# reset_to_initial_stage() // for convenience of testing stages I use next line
	set_current_stage(CraftingStage.ORE_ROCK)


func reset_to_initial_stage() -> void:
	set_current_stage(CraftingStage.ORE_ROCK)


func proceed_to_next_stage() -> void:
	set_current_stage(_current_stage + 1)


func get_current_stage() -> CraftingStage:
	return _current_stage


func set_current_stage(new_stage: CraftingStage) -> void:
	if !CraftingStage.values().has(new_stage): return

	_current_stage = new_stage
	SignalHub.emit_stage_updated(new_stage)


func is_stage_allowed(stage: CraftingStage) -> bool:
	return _current_stage == stage
