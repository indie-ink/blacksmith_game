extends Node

#region Player signals
signal player_action_requested(action_type: Player.ActionTypes)
signal player_action_performed(action_type: Player.ActionTypes)

func emit_player_action_requested(action_type: Player.ActionTypes) -> void: player_action_requested.emit(action_type)
func emit_player_action_performed(action_type: Player.ActionTypes) -> void: player_action_performed.emit(action_type)
#endregion

#region stages passed signals
signal ore_stage_passed
signal ore_heat_passed
signal ore_heat_failed
signal anvil_passed
signal weapon_cooled
signal weapon_sold
signal stage_updated(stage: GameManager.CraftingStage)

func emit_ore_stage_passed() -> void: ore_stage_passed.emit()
func emit_ore_heat_passed() -> void: ore_heat_passed.emit()
func emit_ore_heat_failed() -> void: ore_heat_failed.emit()
func emit_anvil_passed() -> void: anvil_passed.emit()
func emit_weapon_cooled() -> void: weapon_cooled.emit()
func emit_weapon_sold() -> void: weapon_sold.emit()
func emit_stage_updated(stage: GameManager.CraftingStage) -> void: stage_updated.emit(stage)
#endregion

signal ore_taken
signal balance_updated(new_balance: int)

func emit_ore_taken() -> void: ore_taken.emit()
func emit_balance_updated(new_balance: int) -> void: balance_updated.emit(new_balance)
