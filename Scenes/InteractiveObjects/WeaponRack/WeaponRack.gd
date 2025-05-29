class_name WeaponRack

extends InteractiveObject

@onready var pick_up_item: PickUpItem = $PickUpItem

func handle_interaction() -> void:
	if GameManager.is_stage_allowed(GameManager.CraftingStage.IDLE):
		SignalHub.emit_weapon_sold()
		pick_up_item.handle_picked_up()
