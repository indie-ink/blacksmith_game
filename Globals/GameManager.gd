extends Node

enum CraftingStage { IDLE, SIEVE, FURNACE, ANVIL, WATER_BARREL }

var _current_stage: CraftingStage = CraftingStage.IDLE
var _balance := 0
var _current_item_price := 13


func _enter_tree() -> void:
	SignalHub.ore_taken.connect(handle_ore_taken)
	SignalHub.ore_heated.connect(handle_ore_heated)
	SignalHub.anvil_passed.connect(handle_anvil_passed)
	SignalHub.weapon_cooled.connect(handle_weapon_cooled)
	SignalHub.weapon_sold.connect(handle_weapon_sold)


func initial_setup() -> void:
	_balance = 0
	SignalHub.emit_balance_updated(_balance)
	set_current_stage(CraftingStage.IDLE)


func handle_ore_taken() -> void:
	print("Ore taken")
	set_current_stage(CraftingStage.SIEVE)


func handle_ore_heated() -> void:
	print("Ore heated")
	set_current_stage(CraftingStage.FURNACE)


func handle_anvil_passed() -> void:
	print("Anvil passed")
	set_current_stage(CraftingStage.ANVIL)


func handle_weapon_cooled() -> void:
	print("Weapon cooled")
	set_current_stage(CraftingStage.WATER_BARREL)


func handle_weapon_sold() -> void:
	print("Weapon sold")
	_balance += _current_item_price
	SignalHub.emit_balance_updated(_balance)
	set_current_stage(CraftingStage.IDLE)


func get_current_stage() -> CraftingStage:
	return _current_stage


func set_current_stage(new_stage: CraftingStage) -> void:
	if !CraftingStage.values().has(new_stage): return
	
	_current_stage = new_stage
	SignalHub.emit_stage_updated(new_stage)


func is_stage_allowed(stage: CraftingStage) -> bool:
	if _current_stage == CraftingStage.IDLE:
		return stage == CraftingStage.SIEVE

	if _current_stage == CraftingStage.SIEVE:
		return stage == CraftingStage.FURNACE

	if _current_stage == CraftingStage.FURNACE:
		return stage == CraftingStage.ANVIL

	if _current_stage == CraftingStage.ANVIL:
		return stage == CraftingStage.WATER_BARREL

	if _current_stage == CraftingStage.WATER_BARREL:
		return stage == CraftingStage.IDLE
	
	return false
	
