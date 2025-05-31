extends Node

enum CraftingStage { IDLE, ORE_ROCK, FURNACE, ANVIL, WATER_BARREL }

var _current_stage: CraftingStage = CraftingStage.IDLE
var _balance := 0
var _current_item_price := 13


func _enter_tree() -> void:
	SignalHub.ore_stage_passed.connect(handle_ore_stage_passed)
	SignalHub.ore_heat_passed.connect(handle_ore_heat_passed)
	SignalHub.ore_heat_failed.connect(handle_ore_heat_failed)
	SignalHub.anvil_passed.connect(handle_anvil_passed)
	SignalHub.weapon_cooled.connect(handle_weapon_cooled)
	SignalHub.weapon_sold.connect(handle_weapon_sold)


func initial_setup() -> void:
	_balance = 0
	SignalHub.emit_balance_updated(_balance)
	set_current_stage(CraftingStage.IDLE)


func handle_ore_stage_passed() -> void:
	print("Ore taken")
	set_current_stage(CraftingStage.ORE_ROCK)


func handle_ore_heat_passed() -> void:
	print("Ore heated")
	set_current_stage(CraftingStage.FURNACE)


func handle_ore_heat_failed() -> void:
	print("Ore heat FAILED")
	set_current_stage(CraftingStage.IDLE)


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
		return stage == CraftingStage.ORE_ROCK

	if _current_stage == CraftingStage.ORE_ROCK:
		return stage == CraftingStage.FURNACE

	if _current_stage == CraftingStage.FURNACE:
		return stage == CraftingStage.ANVIL

	if _current_stage == CraftingStage.ANVIL:
		return stage == CraftingStage.WATER_BARREL

	if _current_stage == CraftingStage.WATER_BARREL:
		return stage == CraftingStage.IDLE
	
	return false
	
