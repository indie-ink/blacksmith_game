extends Node

#region Player signals
signal player_action_requested(action_type: Player.ActionTypes)
signal player_action_performed(action_type: Player.ActionTypes)
signal player_disable_actions_requested
signal player_enable_actions_requested

func emit_player_action_requested(action_type: Player.ActionTypes) -> void: player_action_requested.emit(action_type)
func emit_player_action_performed(action_type: Player.ActionTypes) -> void: player_action_performed.emit(action_type)
func emit_player_disable_actions_requested() -> void: player_disable_actions_requested.emit()
func emit_player_enable_actions_requested() -> void: player_enable_actions_requested.emit()
#endregion

#region stages passed signals
signal ore_collected
signal ore_stage_passed

signal furnace_stage_passed
signal furnace_heat_updated(heat_time: float, overheat_time: float)
signal furnace_stage_failed

signal anvil_stage_started
signal anvil_hit_reached
signal anvil_hit_missed
signal anvil_stage_failed
signal anvil_stage_passed

signal weapon_cooled

signal weapon_rack_stage_passed

signal stage_updated(stage: GameManager.CraftingStage)

func emit_ore_collected() -> void: ore_collected.emit()
func emit_ore_stage_passed() -> void: ore_stage_passed.emit()
func emit_furnace_stage_passed() -> void: furnace_stage_passed.emit()
func emit_furnace_heat_updated(heat_time: float, overheat_time: float) -> void:
	furnace_heat_updated.emit(heat_time, overheat_time)
func emit_furnace_stage_failed() -> void: furnace_stage_failed.emit()
func emit_anvil_stage_started() -> void: anvil_stage_started.emit()
func emit_anvil_hit_reached() -> void: anvil_hit_reached.emit()
func emit_anvil_hit_missed() -> void: anvil_hit_missed.emit()
func emit_anvil_stage_failed() -> void: anvil_stage_failed.emit()
func emit_anvil_stage_passed() -> void: anvil_stage_passed.emit()
func emit_weapon_cooled() -> void: weapon_cooled.emit()
func emit_weapon_rack_stage_passed() -> void: weapon_rack_stage_passed.emit()
func emit_stage_updated(stage: GameManager.CraftingStage) -> void: stage_updated.emit(stage)
#endregion


#region game state signals

signal ore_stage_state_updated(current_ore: int, required_ore: int)
signal furnace_stage_state_updated(
	current_heat_time: float,
	current_overheat_time: float,
	heat_time_required: float,
	max_overheat_time: float
)
signal anvil_stage_state_updated(
	hits_reached: int,
	hits_missed: int,
	hits_required: int,
	max_hits_missed: int
)
signal reset_stages_states


func emit_ore_stage_state_updated(current_ore: int, required_ore: int) -> void:
	ore_stage_state_updated.emit(current_ore, required_ore)


func emit_furnace_stage_state_updated(
	current_heat_time: float,
	current_overheat_time: float,
	heat_time_required: float,
	max_overheat_time: float
) -> void:
	furnace_stage_state_updated.emit(current_heat_time, current_overheat_time, heat_time_required, max_overheat_time)


func emit_anvil_stage_state_updated(
	hits_reached: int,
	hits_missed: int,
	hits_required: int,
	max_hits_missed: int
) -> void:
	anvil_stage_state_updated.emit(hits_reached, hits_missed, hits_required, max_hits_missed)


func emit_reset_stages_states() -> void: reset_stages_states.emit()

#endregion

signal balance_updated(new_balance: int)

func emit_balance_updated(new_balance: int) -> void: balance_updated.emit(new_balance)
