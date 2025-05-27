extends Node

signal ore_taken
signal ore_heated
signal anvil_hit
signal anvil_passed
signal weapon_cooled
signal weapon_sold
signal stage_updated(stage: GameManager.CraftingStage)
signal balance_updated(new_balance: int)


func emit_ore_taken() -> void: ore_taken.emit()
func emit_ore_heated() -> void: ore_heated.emit()
func emit_anvil_hit() -> void: anvil_hit.emit()
func emit_anvil_passed() -> void: anvil_passed.emit()
func emit_weapon_cooled() -> void: weapon_cooled.emit()
func emit_weapon_sold() -> void: weapon_sold.emit()
func emit_stage_updated(stage: GameManager.CraftingStage) -> void: stage_updated.emit(stage)
func emit_balance_updated(new_balance: int) -> void: balance_updated.emit(new_balance)
