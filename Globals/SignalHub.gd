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
signal ore_taken
signal ore_stage_passed

signal furnace_stage_passed
signal furnace_stage_failed

signal anvil_stage_started
signal anvil_hit_missed
signal anvil_stage_failed
signal anvil_stage_passed

signal weapon_cooled

signal weapon_sold

signal stage_updated(stage: GameManager.CraftingStage)

func emit_ore_taken() -> void: ore_taken.emit()
func emit_ore_stage_passed() -> void: ore_stage_passed.emit()
func emit_furnace_stage_passed() -> void: furnace_stage_passed.emit()
func emit_furnace_stage_failed() -> void: furnace_stage_failed.emit()
func emit_anvil_stage_started() -> void: anvil_stage_started.emit()
func emit_anvil_hit_missed() -> void: anvil_hit_missed.emit()
func emit_anvil_stage_failed() -> void: anvil_stage_failed.emit()
func emit_anvil_stage_passed() -> void: anvil_stage_passed.emit()
func emit_weapon_cooled() -> void: weapon_cooled.emit()
func emit_weapon_sold() -> void: weapon_sold.emit()
func emit_stage_updated(stage: GameManager.CraftingStage) -> void: stage_updated.emit(stage)
#endregion


signal balance_updated(new_balance: int)

func emit_balance_updated(new_balance: int) -> void: balance_updated.emit(new_balance)
