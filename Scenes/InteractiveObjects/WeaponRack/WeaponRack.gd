class_name WeaponRack

extends InteractiveObject

func handle_action() -> void:
	if GameManager.is_stage_allowed(GameManager.CraftingStage.IDLE):
		SignalHub.emit_weapon_sold()
