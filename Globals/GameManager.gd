extends Node

enum CraftingStage { ORE_ROCK, FURNACE, ANVIL, WATER_BARREL, WEAPON_RACK }

var _current_stage: CraftingStage = CraftingStage.ORE_ROCK
var _balance := 0
var _current_item_price := 20
var _current_item_min_price := 15
var _current_item_max_price := 25


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
	set_current_stage(CraftingStage.ORE_ROCK)


func handle_ore_stage_passed() -> void:
	print("Ore taken")
	set_current_stage(CraftingStage.FURNACE)


func handle_ore_heat_passed() -> void:
	print("Ore heated")
	set_current_stage(CraftingStage.ANVIL)


func handle_ore_heat_failed() -> void:
	print("Ore heat FAILED")
	set_current_stage(CraftingStage.ORE_ROCK)


func handle_anvil_passed() -> void:
	print("Anvil passed")
	set_current_stage(CraftingStage.WATER_BARREL)


func handle_weapon_cooled() -> void:
	print("Weapon cooled")
	set_current_stage(CraftingStage.WEAPON_RACK)


func handle_weapon_sold() -> void:
	print("Weapon sold")
	_balance += randf_range(_current_item_min_price, _current_item_max_price)
	SignalHub.emit_balance_updated(_balance)
	set_current_stage(CraftingStage.ORE_ROCK)


func get_current_stage() -> CraftingStage:
	return _current_stage


func set_current_stage(new_stage: CraftingStage) -> void:
	if !CraftingStage.values().has(new_stage): return

	_current_stage = new_stage
	SignalHub.emit_stage_updated(new_stage)


func is_stage_allowed(stage: CraftingStage) -> bool:
	return _current_stage == stage
