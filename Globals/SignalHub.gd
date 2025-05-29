extends Node

signal player_action_requested(action_type: Player.ActionTypes)
signal player_action_performed(action_type: Player.ActionTypes)

signal ore_taken
signal ore_stage_passed
signal ore_heated
signal hammer_hit
signal anvil_passed
signal weapon_cooled
signal weapon_sold
signal stage_updated(stage: GameManager.CraftingStage)
signal balance_updated(new_balance: int)


func emit_player_action_requested(action_type: Player.ActionTypes) -> void: player_action_requested.emit(action_type)
func emit_player_action_performed(action_type: Player.ActionTypes) -> void: player_action_performed.emit(action_type)


func emit_ore_taken() -> void: ore_taken.emit()
func emit_ore_stage_passed() -> void: ore_stage_passed.emit()
func emit_ore_heated() -> void: ore_heated.emit()
func emit_hammer_hit() -> void: hammer_hit.emit()
func emit_anvil_passed() -> void: anvil_passed.emit()
func emit_weapon_cooled() -> void: weapon_cooled.emit()
func emit_weapon_sold() -> void: weapon_sold.emit()
func emit_stage_updated(stage: GameManager.CraftingStage) -> void: stage_updated.emit(stage)
func emit_balance_updated(new_balance: int) -> void: balance_updated.emit(new_balance)
